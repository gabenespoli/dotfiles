# This is the custom theme template for gitprompt.sh

# These are the defaults from the "Default" theme 
# You just need to override what you want to have changed
override_git_prompt_colors() {
  GIT_PROMPT_THEME_NAME="Custom"

  # Base16LightBg="\[\033[48;5;10m\]"
  Base16LightBg=""

  # Time12a="\$(date +%H:%M)"
  # PathShort="\w";

  ## These are the color definitions used by gitprompt.sh
  GIT_PROMPT_PREFIX="${Base16LightBg}["                 # start of the git info string
  GIT_PROMPT_SUFFIX="${Base16LightBg}]"                 # the end of the git info string
  GIT_PROMPT_SEPARATOR="${Base16LightBg}|"              # separates each item

  GIT_PROMPT_BRANCH="${Green}${Base16LightBg}"        # the git branch that is active in the current directory
  GIT_PROMPT_MASTER_BRANCH="${Base16LightBg}${GIT_PROMPT_BRANCH}" # used if the git branch that is active in the current directory is $GIT_PROMPT_MASTER_BRANCHES
  GIT_PROMPT_STAGED="${Magenta}${Base16LightBg}●"           # the number of staged files/directories
  GIT_PROMPT_CONFLICTS="${Red}${Base16LightBg}!"       # the number of files in conflict
  GIT_PROMPT_CHANGED="${Yellow}${Base16LightBg}+"        # the number of changed files

  GIT_PROMPT_REMOTE="${Base16LightBg} "                 # the remote branch name (if any) and the symbols for ahead and behind
  GIT_PROMPT_UNTRACKED="${Cyan}${Base16LightBg}…"       # the number of untracked files/dirs
  GIT_PROMPT_STASHED="${Cyan}${Base16LightBg}⚑"    # the number of stashed files/dir
  GIT_PROMPT_CLEAN="${Green}${Base16LightBg}✔"      # a colored flag indicating a "clean" repo

  ## For the command indicator, the placeholder _LAST_COMMAND_STATE_ 
  ## will be replaced with the exit code of the last command
  ## e.g.
  ## GIT_PROMPT_COMMAND_OK="${Green}✔-_LAST_COMMAND_STATE_ "    # indicator if the last command returned with an exit code of 0
  ## GIT_PROMPT_COMMAND_FAIL="${Red}✘-_LAST_COMMAND_STATE_ "    # indicator if the last command returned with an exit code of other than 0

  GIT_PROMPT_COMMAND_OK=""    # indicator if the last command returned with an exit code of 0
  GIT_PROMPT_COMMAND_FAIL="${Red}${Base16LightBg}✘-_LAST_COMMAND_STATE_"    # indicator if the last command returned with an exit code of other than 0

  ## template for displaying the current virtual environment
  ## use the placeholder _VIRTUALENV_ will be replaced with 
  ## the name of the current virtual environment (currently CONDA and VIRTUAL_ENV)
  GIT_PROMPT_VIRTUALENV="${Base16LightBg}(${Default}_VIRTUALENV_)${ResetColor}"

  # template for displaying the current remote tracking branch
  # use the placeholder _UPSTREAM_ will be replaced with
  # the name of the current remote tracking branch
  GIT_PROMPT_UPSTREAM="${Base16LightBg} {${Blue}_UPSTREAM_${ResetColor}}"

  ## _LAST_COMMAND_INDICATOR_ will be replaced by the appropriate GIT_PROMPT_COMMAND_OK OR GIT_PROMPT_COMMAND_FAIL
  GIT_PROMPT_START_USER="${Blue}${Base16LightBg}${PathShort}${ResetColor}"
  GIT_PROMPT_START_ROOT="${GIT_PROMPT_START_USER}"
  GIT_PROMPT_END_USER="_LAST_COMMAND_INDICATOR_ \n${White}\[\033[48;5;0m\]${Time12a} $>${ResetColor} "
  GIT_PROMPT_END_ROOT="_LAST_COMMAND_INDICATOR_ \n${White}${Time12a}${ResetColor} # "

  ## Please do not add colors to these symbols
  GIT_PROMPT_SYMBOLS_AHEAD="${Base16LightBg}↑·"             # The symbol for "n versions ahead of origin"
  GIT_PROMPT_SYMBOLS_BEHIND="${Base16LightBg}↓·"            # The symbol for "n versions behind of origin"
  GIT_PROMPT_SYMBOLS_PREHASH="${Base16LightBg}:"            # Written before hash of commit, if no name could be found
  GIT_PROMPT_SYMBOLS_NO_REMOTE_TRACKING="${Base16LightBg}L" # This symbol is written after the branch, if the branch is not tracked 

  # branch name(s) that will use $GIT_PROMPT_MASTER_BRANCH color
  # To specify multiple branches, use
  #   shopt -s extglob
  #   GIT_PROMPT_MASTER_BRANCHES='@(master|production)'
  # GIT_PROMPT_MASTER_BRANCHES="master"
}

reload_git_prompt_colors "Custom"
