pipeline {
    agent any
    
    environment {
        WEBHOOK_URL = 'https://ec2-3-70-20-209.eu-central-1.compute.amazonaws.com/postreceive'
        HEALTH_URL = 'https://ec2-3-70-20-209.eu-central-1.compute.amazonaws.com/health'
        WEBHOOK_SECRET = credentials('test-webhook-secret')
        DOCKER_PORT = 10069
        SLACK_CHANNEL = "#jenkins-tests"
        JOB_NAME_DECODED = java.net.URLDecoder.decode(env.JOB_NAME, "UTF-8")
        MAIN_BRANCH = 'main'
        EXP_BRANCH = 'exp'  // experimental 
        DEV_BRANCH = 'dev'
        ALLOWED_BRANCHES = [MAIN_BRANCH, EXP_BRANCH, DEV_BRANCH]  // branches that are allowed to merge into each other
    }
    
    stages {
        stage("Check if coming from correct branch"){
            steps{
                script{
                    if (env.CHANGE_ID) {  // if there is a PR
                        // check from what branch
                        dev_branch_pattern =~ /^((feature)|(bug))\/dev-.*$/
                        exp_branch_pattern =~ /^((feature)|(bug))\/exp-.*$/

                        // Check for `dev`
                        if (env.CHANGE_BRANCH.matches(dev_branch_pattern)){  // if the branch from which the changes are coming (source branch) has `dev-`
                            if(env.CHANGE_TARGET != DEV_BRANCH){  // if the target branch where the changes will be merged into is dev
                                error "Cannot merge branch ${env.CHANGE_BRANCH} with different parent into ${env.CHANGE_TARGET}"
                            }
                        }
                        // Check for `exp`
                        else if (env.CHANGE_BRANCH.matches(exp_branch_pattern)){  // if the branch from which the changes are coming (source branch) has `dev-`
                            if(env.CHANGE_TARGET != EXP_BRANCH){  // if the target branch where the changes will be merged into is dev
                                error "Cannot merge branch ${env.CHANGE_BRANCH} with different parent into ${env.CHANGE_TARGET}"
                            }
                        }

                        // Check if they we are merging dev->exp->main 
                        if (env.CHANGE_BRANCH == DEV_BRANCH){
                            if (env.CHANGE_TARGET != EXP_BRANCH){
                                error "Cannot merge branch ${env.CHANGE_BRANCH} into a branch that is not strictly one level higher (${EXP_BRANCH})"
                            }
                        }
                        else if (env.CHANGE_BRANCH == EXP_BRANCH){
                            if (env.CHANGE_TARGET != MAIN_BRANCH){
                                error "Cannot merge branch ${env.CHANGE_BRANCH} into a branch that is not strictly one level higher (${MAIN_BRANCH})"
                            }
                        }

                    }
                }
            }
        }
        stage ("Mini test"){
            steps{
                script{
                    echo "Hello, world! Ana are mere."
                }
            }
        }
    }
}