# DevOps Coding Challenge

Welcome to our DevOps coding challenge! This challenge is designed to assess your skills in Docker, CI/CD, AWS, and Observability. You will be provided with 4 unique challenges and your goal is to choose 3 and try to complete as many of their tasks as you can or as is applicable. While you don't have to complete every challenge, you should be able to speak to a process for how to resolve each challenge in the follow-up technical screening.  Ideally, you shouldn't spend more than 5 hours on this challenge. If you find that the exercise requires more time, feel free to submit your exercise with pseudo-code and descriptions of what you planned to do but couldn’t complete.  This is a new process for us and we want to hear your feedback/questions if you have them.

## The Story

You are approached by a software developer named Spruce Bingsteen who is working on a new web application to revolutionize the way we experience the beasts in the Bible. Spruce is looking for help with the DevOps side of the application. He has provided you with a repository that contains the source code along with some commands to run the service locally. Spruce is stoked because he has made his first Dockerfile but he is complaining that it takes long to build everytime he makes a change. He has asked you to help with the following:

## Challenges - Choose 3

Please only select 3 of the following challenges.
1. **Docker**: You will find a Dockerfile in the root directory of this repository. The Dockerfile is poorly formatted and users are complaining that it takes too long to build the Docker image every time they make a change. It appears all the dependencies are being installed every time there is a change to any file in the repo.
Tasks:
    - Optimize the Dockerfile to reduce the build time and size of the Docker image.
    - Is there anything that wouldn't function as expected in the Dockerfile?
    - Be ready to explain your changes and why you made them.

2. **CI/CD**: Create a github actions workflow(s) for this repository.
Tasks:
    - Can you automate (choose at least one):
        - The build and push of the Docker image to the Github Container Registry?
        - The deployment of the application to AWS?
        - The observability setup for the application?
    - Are there any other automations you can think of that would be useful for this application?
    - Can you show what branching strategy and development workflow you would choose for this application? (assume there will be anywhere from 5-10 developers working in this repository)

3. **AWS Deployment**: Deploy the application to AWS. You can choose to use any AWS service you want to deploy the application but you should aim to land on a containerized solution (not just a static site because thats not what Spruce was looking for). NOTE: You will need to use your own AWS account for this task.  We will provide you with an additional $25 to cover any hosting fees for this challenge. If your hosting fees exceed $25, you are headed down the wrong path.
Tasks:
    - Be ready to explain your deployment process and why you chose the AWS service(s) you did.
    - While using an IAC tool is not required, the process for deploying the application should be well defined and repeatable enough for Spruce to be able to repeat the process.
    - You should be able to provide access to the hosted application, which can be achieved without the need for a unique domain or Route 53 entries. It could simply be an IP address or the generated AWS URL.
    - Once deployed, provide instructions for how updates to the application would be deployed by Spruce.

4. **Observability**: Set up observability for the application. This could include application logs, metrics, and traces. We strongly recommend you use New Relic for this challenge as that is the tool we are currently using. Be prepared to show how you would use the observability tools to debug an issue with the application. Tasks:
    - The process for setting up observability should be well defined and repeatable.
    - Can you use any IAC tools to configure your dashboards and settings?
    - The observability setup should be able to provide useful information for debugging issues with the application.
    - You can set up observability for the application locally or in AWS.

## Submission

Please fork this repository, make your changes, and send an email to tucker.hayden@bibleproject.com and david.carroll@bibleproject.com with the a link to your repo when you are finished (if it is a private repo please add the users [axesilo](https://github.com/axesilo) and [Tjhayhay](https://github.com/Tjhayhay). In your technical screening interview you will be expected to provide a brief explanation of your work.  Again, This is a new process for us and we want to hear your feedback/questions if you have them. So please feel free to reach out if you are feeling stuck.

Good luck!

## To run the application locally

First, run the server:

```bash
npm run dev
# or
yarn dev
# or
pnpm dev
# or
bun dev
```

Open [http://localhost:3000](http://localhost:3000) with your browser to see the result.


## Hey Spruce Bingsteen!

Nice to make your acquaintance. Sorry to hear about some of the trouble that you are experiencing. I would love to help you out! I've taken a look at your "Bible Beasts Project". Very cool! I checked out the issues you mentioned and added comments below for each of the sections as well as provided links to the staging and production apps. Hope they are helpful and I'll schedule a time for next week to provide a brief explanation of everything. cheers!

Here are the links to the hosted applications:

[Staging Application](http://staging-bb-load-balancer-847918050.us-east-1.elb.amazonaws.com:3000/)

[Production Application](http://prod-bb-load-balancer-1491557060.us-east-1.elb.amazonaws.com:3000/)

1. **Docker Notes**:
Great start here for the Dockerfile, Spruce! I made a few updates as outlined below to improve build time and size of the docker image:

    1. Set up a **multi-stage build approach** which helps reduce the size of the final image by using a smaller base image at runtime
    2. Specified a specific and **recent version of Node.js** for the application. Node version 18 no longer has Active Support.
    3. **Leveraged docker build cache** by installing depencencies in a separate, earlier layer of the Dockerfile. This reduces unnecessary dependancy installations.
    4. Removed the build-time.txt command as the timestamp information is available in the metadata

2. **CI/CD**:
For the CI/CD I used github actions. I set up the following actions in your repository:

- **pre-commit.yml:** It helps ensure code quality by running checks (formatting, linting, tests) before allowing pull requests to pass.
    - **NOTE:** There is a branch with additional precommit hooks if you are interested in additional linting or formatting

- **staging.yml:** This workflow builds, pushes, and deploys to the staging environment.

- **prod.yml:** This workflow builds, pushes, and deploys to the staging environment.

- **snyk security scan step:** There is a step in the build job of both environment yml files that runs a security scan on your docker image to check for known vulnerabilities

In regards to a **branching strategy and developer workflow** I recommend adopting a **trunk based development** strategy. This method revolves around a single primary branch (known as the 'trunk'), where developers are encouraged to make small, frequent commits directly to this main branch. It facilitates rapid validation and integration of changes. This model is designed to minimize the complexity involved in managing long-lived branches and promotes collaboration, ensuring that changes are immediately visible to the entire team. This workflow aligns seamlessly with shorter development cycles and a need for expedited feedback.

If necessary, feature flags are often employed to conceal ongoing work, offering flexibility as the application evolves.

Presently, the GitHub repository is configured with two environments, namely **staging** and **prod**. In a trunk-based development workflow, we utilize these environments in the following manner:

- **Staging Environment:** In trunk-based development, the staging environment isn't a mandatory part of the "promotion workflow," yet it serves as a component within your development lifecycle. It functions as a "sandbox" during the development of your Bible Beasts Project. Here is a [helpful blog post](https://jhall.io/archive/2022/07/01/can-we-use-a-staging-environment-with-trunk-based-development/) that delves into aspects of this workflow. Also, please refer to the diagram below.

- **Production Environment:** This environment represents the production environment. Once you've completed your pull request changes and have verified them in the staging environment, the pull request can be merged and automatically deployed to the production environment. Ideally, with this setup, you should aim to automate as much testing as possible.

NOTE: If the probject gets more intricate or automated testing is not feasible, you may want to look into creating an additional environment called "QA", which could be a longer lived testing environment before the push to the production environment.

![Deployment layout](development_workflow.png)

**Updates to your Application:**
When updating your application:
1. Make changes to your application using a pull request
2. Github actions will push those changes to the staging environment. Test your changes in the staging environment.
3. Merge the pull request to deploy to production

I'm happy to go into more details and provide more thorough instructions when we hop on a call next week!

3. **AWS Deployment**:
The AWS resources were deployed using Terraform (IAC tool).

I set up AWS ECS, using Fargate, and supporting AWS resources via Terraform and used Terraform workspaces to set up different AWS infracture for the staging and production environments. Happy to go over those in more detail on our call!

I also set up a Makefile in the /terraform folder which should help you run any terraform commands you need if you want to create your own infrastructure or update any of the infrastructure. Type the command "make" in the "/terraform" folder in your Bible Beasts App directory to get started. Happy Terraforming!

4. **Observability**:
I was hoping to spend additional time in this observability section to have insight into your application performance. However, I did not get to this section. I did find some good resources to get you started and pushed up a draft pull request!


- A [draft pull request](https://github.com/highonchai/Bible-Beasts-Project/pull/16) with the start to creating Terraform code to set up a dashboard that monitors the golden signals of observability:
    **1. Latency:** The amount of time it takes your application to service a request.
    **2. Traffic:** The amount of requests your system receives.
    **3. Errors:** The rate of requests that fail.
    **4. Saturation:** The stress on resources to meet the demands of your application.
Here is a helpful document for [getting started with terraform from New Relic](https://docs.newrelic.com/docs/more-integrations/terraform/terraform-intro/)
