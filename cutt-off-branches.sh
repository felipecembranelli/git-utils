########################################################################
# Constants
########################################################################
OLD_VERSION=RC-1.6 # ideally we should use PROD-LATEST
NEW_VERSION=RC-1.7
#REPOS_FILE="./micro-services-repos.txt"
REPOS=( $(cat "${REPOS_FILE}") )
 
########################################################
# Repositoryes root folder
########################################################
TARGET_DIR=/Users/lvendramin/prj/deploy/beesus
 
########################################################################
# Execute git operations for all repos
########################################################################
## declare an array variable
 
TARGET_DIR=$(printf "$TARGET_DIR-$NEW_VERSION-%03d" $(($RANDOM%9999+1)))
 
mkdir -p $TARGET_DIR
 
declare -a arr=(
  "git clone git@ssh.dev.azure.com:v3/ciandt-ab-inbev/US_B2B_DELTA/{REPOS} ${TARGET_DIR}/{REPOS}"
  "git -C \"$TARGET_DIR/{REPOS}\" checkout $OLD_VERSION"
  "git -C \"$TARGET_DIR/{REPOS}\" status"
  "git -C \"$TARGET_DIR/{REPOS}\" checkout -b $NEW_VERSION"
  "git -C \"$TARGET_DIR/{REPOS}\" push origin $NEW_VERSION"
)
 
for cmd in "${arr[@]}"
do
  echo
  for i in "${!REPOS[@]}"
  do
    # modify this line as needed
    COMMAND=${cmd//\{REPOS\}/${REPOS[$i]}}
    echo "Running ${COMMAND}"
    eval $COMMAND
    echo
  done
 
  #sleep 5s
  #read -p "Press enter to continue"
done
 
read -p "DONE; Press enter to delete $TARGET_DIR; ctrl+c to abort"
rm -r $TARGET_DIR
 
 
 

