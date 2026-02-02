#!/bin/bash

# Git Kit v2
#
# 설치 (택1):
#   시스템 전역: chmod +x git-gk.sh && sudo mv git-gk.sh /usr/local/bin/git-gk
#   사용자 전용: chmod +x git-gk.sh && mv git-gk.sh ~/.local/bin/git-gk
#
# Git alias 등록: git config --global alias.gk '!git-gk'

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m'

# Global options
DRY_RUN=false
VERBOSE=false

# Parse global options
parse_global_opts() {
    while [[ "$1" =~ ^- ]]; do
        case "$1" in
            -n|--dry-run) DRY_RUN=true; shift ;;
            -v|--verbose) VERBOSE=true; shift ;;
            *) break ;;
        esac
    done
    echo "$@"
}

# Run git command with output
run_git() {
    echo -e "${CYAN}$ git $*${NC}"
    if [ "$DRY_RUN" = true ]; then
        echo -e "${YELLOW}(dry-run: 실행하지 않음)${NC}"
        return 0
    fi
    git "$@"
}

# Check git repo
check_git() {
    if ! git rev-parse --is-inside-work-tree &>/dev/null; then
        echo -e "${RED}Error: git 저장소가 아닙니다${NC}"
        exit 1
    fi
}

# prune: 원격에서 삭제된 브랜치 정리
cmd_prune() {
    echo -e "${GREEN}[prune]${NC} 원격에서 삭제된 브랜치 추적 정리"
    echo ""

    # Show what will be pruned
    STALE=$(git remote prune origin --dry-run 2>/dev/null | grep '\[would prune\]' || true)
    if [ -z "$STALE" ]; then
        echo "정리할 브랜치가 없습니다."
        return 0
    fi

    echo "삭제될 추적 브랜치:"
    echo "$STALE" | sed 's/.*\[would prune\]/  -/'
    echo ""

    run_git fetch --prune
}

# clean: 머지된 브랜치 삭제
cmd_clean() {
    local BASE="${1:-develop}"
    echo -e "${GREEN}[clean]${NC} ${BASE}에 머지된 브랜치 삭제"
    echo ""

    # Fetch first
    run_git fetch origin "$BASE"

    # Find merged branches
    MERGED=$(git branch --merged "origin/${BASE}" 2>/dev/null | grep -vE "^\*|main|master|develop" | sed 's/^[ \t]*//' || true)

    if [ -z "$MERGED" ]; then
        echo "삭제할 브랜치가 없습니다."
        return 0
    fi

    echo "삭제될 브랜치:"
    echo "$MERGED" | while read branch; do
        LAST=$(git log -1 --format="%cr" "$branch" 2>/dev/null || echo "?")
        echo "  - $branch ($LAST)"
    done
    echo ""

    if [ "$DRY_RUN" = true ]; then
        echo -e "${YELLOW}(dry-run: 실제로 삭제하지 않음)${NC}"
        return 0
    fi

    echo "$MERGED" | while read branch; do
        run_git branch -d "$branch"
    done
}

# squash: 커밋 합치기
cmd_squash() {
    local BASE="${1:-develop}"
    [[ ! "$BASE" =~ ^origin/ ]] && BASE="origin/$BASE"

    CURRENT=$(git branch --show-current)
    MERGE_BASE=$(git merge-base HEAD "$BASE" 2>/dev/null) || {
        echo -e "${RED}Error: $BASE 를 찾을 수 없습니다${NC}"
        exit 1
    }
    COUNT=$(git rev-list --count "${MERGE_BASE}..HEAD")

    echo -e "${GREEN}[squash]${NC} ${CURRENT}의 ${COUNT}개 커밋을 하나로 합치기"
    echo ""

    if [ "$COUNT" -eq 0 ]; then
        echo "합칠 커밋이 없습니다."
        return 0
    fi

    echo "합쳐질 커밋들:"
    git log --oneline "${MERGE_BASE}..HEAD" | head -10
    [ "$COUNT" -gt 10 ] && echo "  ... 외 $((COUNT - 10))개"
    echo ""

    run_git reset --soft "$MERGE_BASE"

    if [ "$DRY_RUN" = false ]; then
        echo ""
        echo -e "${YELLOW}다음 단계:${NC}"
        echo "  git commit -m \"your message\""
        echo "  git push --force-with-lease"
    fi
}

# stale: 오래된 브랜치 찾기
cmd_stale() {
    local DAYS="${1:-90}"
    echo -e "${GREEN}[stale]${NC} ${DAYS}일 이상 활동 없는 브랜치"
    echo ""

    # macOS/Linux 호환
    if date -v-1d &>/dev/null; then
        CUTOFF=$(date -v-${DAYS}d +%Y-%m-%d)
    else
        CUTOFF=$(date -d "${DAYS} days ago" +%Y-%m-%d)
    fi

    echo "로컬 브랜치:"
    git for-each-ref --sort=committerdate --format='%(committerdate:short)|%(refname:short)|%(authorname)' refs/heads/ | \
    while IFS='|' read date branch author; do
        if [[ "$date" < "$CUTOFF" ]]; then
            echo -e "  ${RED}$date${NC}  $branch  ${CYAN}[$author]${NC}"
        fi
    done

    echo ""
    echo "원격 브랜치:"
    git for-each-ref --sort=committerdate --format='%(committerdate:short)|%(refname:short)|%(authorname)' refs/remotes/origin/ | \
    grep -v HEAD | \
    while IFS='|' read date branch author; do
        if [[ "$date" < "$CUTOFF" ]]; then
            SHORT=${branch#origin/}
            echo -e "  ${RED}$date${NC}  $SHORT  ${CYAN}[$author]${NC}"
        fi
    done
}

# log: 커밋 로그 보기
cmd_log() {
    local COUNT="20"
    local ALL_FLAG=""

    # 모든 인자 처리
    for arg in "$@"; do
        case "$arg" in
            -a|--all) ALL_FLAG="--all" ;;
            [0-9]*) COUNT="$arg" ;;
        esac
    done

    git log --graph $ALL_FLAG --pretty=format:'%C(auto)%h%d %s %C(dim)(%cr) <%an>' -n "$COUNT"
}

# status: 브랜치 상태 보기
cmd_status() {
    local BASE="${1:-develop}"
    echo -e "${GREEN}[status]${NC} 브랜치 상태"
    echo ""

    CURRENT=$(git branch --show-current)
    echo "현재 브랜치: $CURRENT"
    echo ""

    run_git branch -vv
}

# recent: 최근 작업 브랜치
cmd_recent() {
    local COUNT="${1:-10}"
    echo -e "${GREEN}[recent]${NC} 최근 체크아웃한 브랜치"
    echo ""

    git reflog show --pretty=format:'%gs' | \
        grep -o 'checkout: moving from .* to .*' | \
        sed 's/checkout: moving from .* to //' | \
        awk '!seen[$0]++' | \
        head -n "$COUNT" | \
        nl -w2 -s'. '
}

# sync: 브랜치 동기화
cmd_sync() {
    local BASE="${1:-develop}"
    local CURRENT=$(git branch --show-current)

    echo -e "${GREEN}[sync]${NC} ${CURRENT}를 ${BASE}와 동기화"
    echo ""

    # fetch first
    run_git fetch origin "$BASE"

    # rebase
    run_git rebase "origin/$BASE"
}

# info: 브랜치 상세 정보
cmd_info() {
    local BRANCH="${1:-$(git branch --show-current)}"
    echo -e "${GREEN}[info]${NC} ${BRANCH} 브랜치 정보"
    echo ""

    # 브랜치 존재 확인
    if ! git show-ref --verify --quiet "refs/heads/$BRANCH"; then
        echo -e "${RED}Error: 브랜치 '$BRANCH'를 찾을 수 없습니다${NC}"
        return 1
    fi

    # 트래킹 정보
    local TRACKING=$(git for-each-ref --format='%(upstream:short)' "refs/heads/$BRANCH")
    echo "트래킹: ${TRACKING:-없음}"

    # ahead/behind
    if [ -n "$TRACKING" ]; then
        local AHEAD=$(git rev-list --count "$TRACKING..$BRANCH" 2>/dev/null || echo 0)
        local BEHIND=$(git rev-list --count "$BRANCH..$TRACKING" 2>/dev/null || echo 0)
        echo "상태: ↑${AHEAD} ↓${BEHIND}"
    fi

    # 마지막 커밋
    echo ""
    echo "마지막 커밋:"
    git log -1 --format="  %h %s (%cr) <%an>" "$BRANCH"

    # 생성 시점 (대략적)
    local FIRST_COMMIT=$(git rev-list --max-parents=0 "$BRANCH" 2>/dev/null | head -1)
    local MERGE_BASE=$(git merge-base "$BRANCH" origin/main 2>/dev/null || git merge-base "$BRANCH" origin/master 2>/dev/null || echo "")
    if [ -n "$MERGE_BASE" ]; then
        local COMMITS=$(git rev-list --count "$MERGE_BASE..$BRANCH")
        echo ""
        echo "main과의 차이: ${COMMITS}개 커밋"
    fi
}

# delete: 안전한 브랜치 삭제
cmd_delete() {
    local BRANCH="$1"
    local FORCE=false
    local REMOTE=false

    # 옵션 파싱
    for arg in "$@"; do
        case "$arg" in
            -f|--force) FORCE=true ;;
            -r|--remote) REMOTE=true ;;
            -*) ;;
            *) BRANCH="$arg" ;;
        esac
    done

    if [ -z "$BRANCH" ]; then
        echo -e "${RED}Error: 브랜치 이름을 지정하세요${NC}"
        echo "사용법: git gk delete <branch> [-f] [-r]"
        return 1
    fi

    # 현재 브랜치 체크
    local CURRENT=$(git branch --show-current)
    if [ "$BRANCH" = "$CURRENT" ]; then
        echo -e "${RED}Error: 현재 브랜치는 삭제할 수 없습니다${NC}"
        return 1
    fi

    # 보호된 브랜치 체크
    if [[ "$BRANCH" =~ ^(main|master|develop)$ ]]; then
        echo -e "${RED}Error: 보호된 브랜치입니다: $BRANCH${NC}"
        return 1
    fi

    echo -e "${GREEN}[delete]${NC} 브랜치 삭제: $BRANCH"
    echo ""

    # 브랜치 정보 표시
    if git show-ref --verify --quiet "refs/heads/$BRANCH"; then
        echo "로컬 브랜치:"
        git log -1 --format="  %h %s (%cr)" "$BRANCH"
    fi

    if git show-ref --verify --quiet "refs/remotes/origin/$BRANCH"; then
        echo "원격 브랜치: origin/$BRANCH"
    fi
    echo ""

    # 로컬 삭제
    if git show-ref --verify --quiet "refs/heads/$BRANCH"; then
        if [ "$FORCE" = true ]; then
            run_git branch -D "$BRANCH"
        else
            run_git branch -d "$BRANCH"
        fi
    fi

    # 원격 삭제
    if [ "$REMOTE" = true ]; then
        if git show-ref --verify --quiet "refs/remotes/origin/$BRANCH"; then
            run_git push origin --delete "$BRANCH"
        fi
    fi
}

# switch: 빠른 브랜치 전환
cmd_switch() {
    local PATTERN="$1"

    # 인자 없으면 fzf 또는 목록 표시
    if [ -z "$PATTERN" ]; then
        if command -v fzf &>/dev/null; then
            local SELECTED=$(git branch --format='%(refname:short)' | fzf --height=40% --reverse)
            if [ -n "$SELECTED" ]; then
                run_git checkout "$SELECTED"
            fi
        else
            echo -e "${GREEN}[switch]${NC} 브랜치 목록 (fzf 설치 시 인터랙티브 선택 가능)"
            echo ""
            git branch --format='%(refname:short)' | nl -w2 -s'. '
            echo ""
            echo "사용법: git gk sw <브랜치명 또는 패턴>"
        fi
        return 0
    fi

    # 정확한 매칭 시도
    if git show-ref --verify --quiet "refs/heads/$PATTERN"; then
        run_git checkout "$PATTERN"
        return 0
    fi

    # 패턴 매칭
    local MATCHES=$(git branch --format='%(refname:short)' | grep -i "$PATTERN")
    local COUNT=$(echo "$MATCHES" | grep -c . || echo 0)

    if [ "$COUNT" -eq 0 ]; then
        echo -e "${RED}Error: '$PATTERN' 패턴과 일치하는 브랜치가 없습니다${NC}"
        return 1
    elif [ "$COUNT" -eq 1 ]; then
        run_git checkout "$MATCHES"
    else
        echo -e "${YELLOW}여러 브랜치가 매칭됩니다:${NC}"
        echo "$MATCHES" | nl -w2 -s'. '
        echo ""
        echo "더 구체적인 패턴을 사용하세요."
    fi
}

# undo: 실수 복구
cmd_undo() {
    local MODE="soft"

    for arg in "$@"; do
        case "$arg" in
            --hard) MODE="hard" ;;
            --soft) MODE="soft" ;;
        esac
    done

    echo -e "${GREEN}[undo]${NC} 마지막 커밋 취소 (--$MODE)"
    echo ""

    # 취소할 커밋 표시
    echo "취소될 커밋:"
    git log -1 --format="  %h %s (%cr) <%an>"
    echo ""

    if [ "$MODE" = "hard" ]; then
        run_git reset --hard HEAD~1
    else
        run_git reset --soft HEAD~1
        if [ "$DRY_RUN" = false ]; then
            echo ""
            echo -e "${YELLOW}변경사항이 스테이징 영역에 남아있습니다.${NC}"
        fi
    fi
}

# discard: 수정 사항 버리기
cmd_discard() {
    local ALL=false
    local STAGED=false
    local FILES=()

    # 옵션 파싱
    for arg in "$@"; do
        case "$arg" in
            -a|--all) ALL=true ;;
            -s|--staged) STAGED=true ;;
            -*) ;;
            *) FILES+=("$arg") ;;
        esac
    done

    # 인자 검증
    if [ "$ALL" = false ] && [ ${#FILES[@]} -eq 0 ]; then
        echo -e "${RED}Error: 파일을 지정하거나 --all 옵션을 사용하세요${NC}"
        echo "사용법: git gk discard <file>..."
        echo "        git gk discard --all"
        return 1
    fi

    echo -e "${GREEN}[discard]${NC} 수정 사항 버리기"
    echo ""

    # 변경사항 표시
    if [ "$ALL" = true ]; then
        echo "버려질 변경사항:"
        git status --short
        echo ""

        if [ "$STAGED" = true ]; then
            run_git reset HEAD
        fi
        run_git checkout -- .
    else
        echo "버려질 파일:"
        for file in "${FILES[@]}"; do
            if [ -f "$file" ] || git ls-files --error-unmatch "$file" &>/dev/null; then
                git status --short "$file"
            else
                echo -e "${YELLOW}  (없음) $file${NC}"
            fi
        done
        echo ""

        for file in "${FILES[@]}"; do
            if [ "$STAGED" = true ]; then
                run_git reset HEAD "$file" 2>/dev/null || true
            fi
            run_git checkout -- "$file"
        done
    fi
}

# help: 도움말
show_help() {
    cat << 'EOF'
Git Kit v2

사용법: git-gk [옵션] <명령> [인자]

전역 옵션:
  -n, --dry-run    실제 실행하지 않고 명령만 출력
  -v, --verbose    상세 출력

명령:
  prune            원격에서 삭제된 브랜치 추적 정리
                   예: git gk prune

  clean [base]     base 브랜치에 머지된 로컬 브랜치 삭제
                   기본값: develop
                   예: git gk clean
                   예: git gk clean main

  squash [base]    현재 브랜치의 커밋들을 하나로 합치기 (soft reset)
                   기본값: origin/develop
                   예: git gk squash
                   예: git gk squash main

  stale [days]     지정된 일수 이상 활동 없는 브랜치 찾기
                   기본값: 90일
                   예: git gk stale
                   예: git gk stale 60

  status [base]    브랜치 상태 종합 보기
                   예: git gk status

  log [n] [-a]     커밋 로그 보기 (그래프 포함)
                   기본값: 20개
                   -a, --all: 모든 브랜치 표시
                   예: git gk log
                   예: git gk log 50
                   예: git gk log -a

  recent [n]       최근 체크아웃한 브랜치 목록
                   기본값: 10개
                   예: git gk recent
                   예: git gk recent 5

  sync [base]      현재 브랜치를 base와 동기화 (fetch + rebase)
                   기본값: develop
                   예: git gk sync
                   예: git gk sync main

  info [branch]    브랜치 상세 정보 (트래킹, ahead/behind 등)
                   기본값: 현재 브랜치
                   예: git gk info
                   예: git gk info feature/login

  delete <branch>  브랜치 삭제 (안전 모드)
  rm <branch>      -f, --force: 강제 삭제
                   -r, --remote: 원격도 함께 삭제
                   예: git gk delete feature/old
                   예: git gk rm feature/old -f -r

  switch [pattern] 브랜치 전환 (패턴 매칭)
  sw [pattern]     인자 없이: fzf 인터랙티브 선택 (설치 시)
                   예: git gk sw
                   예: git gk sw feature
                   예: git gk sw login

  undo [--hard]    마지막 커밋 취소
                   기본: --soft (변경사항 유지)
                   --hard: 변경사항도 삭제
                   예: git gk undo
                   예: git gk undo --hard

  discard <file>   수정 사항 버리기 (커밋 전 변경사항 롤백)
                   --all, -a: 모든 수정 파일 롤백
                   --staged, -s: 스테이징된 것도 함께 처리
                   예: git gk discard src/main.js
                   예: git gk discard --all
                   예: git gk discard --all --staged

  help             이 도움말 표시

설치 (택1):
  시스템 전역:
    chmod +x git-gk.sh
    sudo mv git-gk.sh /usr/local/bin/git-gk

  사용자 전용:
    chmod +x git-gk.sh
    mv git-gk.sh ~/.local/bin/git-gk
    # ~/.local/bin이 PATH에 없다면: export PATH="$HOME/.local/bin:$PATH"

Git alias 등록:
  git config --global alias.gk '!git-gk'

Git alias 제거:
  git config --global --unset alias.gk

Git log alias (빠른 접근용):
  git config --global alias.lg "log --graph --pretty=format:'%C(auto)%h%d %s %C(dim)(%cr) <%an>'"
  git config --global alias.lga "log --graph --all --pretty=format:'%C(auto)%h%d %s %C(dim)(%cr) <%an>'"

사용 예시:
  git gk -n clean          # dry-run: 실제 삭제 없이 확인만
  git gk prune             # 원격 정리
  git gk clean main        # main에 머지된 브랜치 삭제
  git gk squash develop    # develop 기준 커밋 합치기
EOF
}

# Main
ARGS=$(parse_global_opts "$@")
set -- $ARGS

check_git

case "${1:-help}" in
    prune)       cmd_prune ;;
    clean)       cmd_clean "$2" ;;
    squash)      cmd_squash "$2" ;;
    stale)       cmd_stale "$2" ;;
    status|st)   cmd_status "$2" ;;
    log|lg)      cmd_log "$2" "$3" ;;
    recent)      cmd_recent "$2" ;;
    sync)        cmd_sync "$2" ;;
    info)        cmd_info "$2" ;;
    delete|rm)   cmd_delete "$2" "$3" "$4" ;;
    switch|sw)   cmd_switch "$2" ;;
    undo)        cmd_undo "$2" ;;
    discard)     cmd_discard "$2" "$3" "$4" "$5" ;;
    help|-h|--help) show_help ;;
    *)
        echo -e "${RED}Unknown command: $1${NC}"
        echo "Run 'git-gk help' for usage."
        exit 1
        ;;
esac
