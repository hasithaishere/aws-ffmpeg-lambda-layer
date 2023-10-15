<p align='center'> <img src="https://user-images.githubusercontent.com/4580975/275339760-e9e95dcd-afd5-4ed0-9d3f-f739bd9e9a4a.jpg"/></p>

<h1  align='center'>FFmpeg/FFprobe AWS Lambda Layer (Based on Amazon Linux 2 AMIs)</h1>

This repository hosts a custom AWS Lambda layer that includes static versions of FFmpeg and FFprobe utilities from the FFmpeg Linux package. These utilities are compatible with both Amazon Linux 2.x and Amazon Linux 1.x instances.

#### Supported AWS 
- nodejs18.x
- nodejs16.x
- nodejs14.x
- python3.11
- java17
- go1.x

## Prerequisites

* Unix Make environment
* [SAM CLI](https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/install-sam-cli.html) tool

## Deploying to AWS as a layer

This layer can deployed in the AWS using following commands:

For Build the layer please use the following command:

```sh
make build
```

For Deploy the layer please use the following command:

```sh
make deploy AWS_REGION=<AWS_REGION> STACK_NAME=<STACK_NAME> 
```

By default, this uses `ffmpeg-lambda-layer` as the stack name. Provide a `STACK_NAME` variable when calling `make deploy` to use an alternative name.

And default region is `ap-southeast-1` if you want to deploy in different region please provide `AWS_REGION` variable.


The `ffmpeg` and `ffprobe` binaries will be in `/opt/bin/` after linking the layer to a Lambda function.

```sh
make deploy
```

This package includes FFmpeg 6.0, packaged by John Van Sickle. Please consider supporting him for maintaining statically built FFmpeg packages. For more information, check out https://johnvansickle.com/ffmpeg/

### How to use

After deploy the layer, you can use the ARN of layer in your lambda function.
It return the latest layer ARN, please check following screenshot.

```sh
arn:aws:lambda:ap-southeast-1:<AWS-ACCOUNT-ID>:layer:ffmpeg-lambda-layer:1  
```

<p align='center'> <img src="https://user-images.githubusercontent.com/4580975/275339769-a87fc0c9-2d72-4d7b-b341-69f051cda034.png"/></p> </p> 

You can use this ARN in your serverless function as following:

```yaml
Resources:
  MediaConverterFunction:
    Type: AWS::Serverless::Function
    Properties:
      CodeUri: media-converter/
      Handler: app.lambdaHandler
      Runtime: nodejs18.x
      Timeout: 30
```

## Author

[Hasitha Gamage](https://hasitha.xyz)

## License

* These Repository Code: [GPL v3](https://opensource.org/licenses/MIT)
* FFmpeg: GPLv2.1 <http://ffmpeg.org/legal.html>, John Van Sickle's static build GPL v3 <https://johnvansickle.com/ffmpeg/>