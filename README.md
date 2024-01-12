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
