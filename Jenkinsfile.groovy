pipelineJob('terraform-jenkins-poc') {
  description('')
  logRotator(5, 5)
  parameters {
   stringParam('gitBranch', 'master', 'Git branch name')
   choiceParam('terraformenv', ['dev2'], 'Environments where infrastructure needs to be deployed')
   choiceParam('terraformaccounttype', ['nonprod'], 'The account type the job will run against')  
   choiceParam('terraformApplyPlan', ['false','true'], 'true: run a terraform plan and apply<br>\
    false: run a terraform plan only')
  }
 definition {
   cps {
     script(readFileFromWorkspace('pipelines/Jenkins-terraform-poc')
	 sandbox()
    }
  }
} 
