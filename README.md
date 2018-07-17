dumblog-chef
============

Rudimentary Chef::Handler for go-dumblog to publish failed chef-client runs to AWS CloudWatch Logs.

Credit [Brian Bianco](https://github.com/brianbianco) for the [go-dumblog](https://github.com/brianbianco/go-dumblog) utility.

## Usage

Ability to customize AWS CloudWatch Logs group, default: '/chef'

### Install `dumblog-chef` gem

```shell
gem install dumblog
```

### Add to client.rb

```ruby
["dumblog-chef"].each do |lib|
  begin
    require lib
  rescue LoadError
    Chef::Log.warn "Failed to load #{lib}. This should be resolved after a chef run."
  end
end

exception_handlers << DumblogChef::Handler.new('/AWS/CLOUDWATCH/LOGS/GROUP')
```

## Disclaimer

It may work for your use-case out-of-the-box, but it's much more likely you'll need to fork it and customize it for your needs.

NOTE: This handler was built to solve a pressing issue in a legacy system utilizing Chef.

It assumes the use of IAM roles on AWS Instances with proper policies to publish logs to AWS CloudWatch Logs via [go-dumblog](https://github.com/brianbianco/go-dumblog).  It makes assumptions and contains only minimal flexibility with the ability to customize the group for AWS CloudWatch Logs.
