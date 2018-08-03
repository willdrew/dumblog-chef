# encoding: UTF-8

module DumblogChef
  class Handler < Chef::Handler
    attr_reader   :time, :instance_id
    attr_reader   :group, :stream, :region

    def initialize(group='/chef', stream=nil, region=nil)
      @time          = Time.now.utc
      @instance_id   = `wget -qO- http://169.254.169.254/latest/meta-data/instance-id`

      @group = group
      @stream = [nil, ''].include?(stream) ? "#{time.strftime("%Y/%m/%d")}/#{instance_id}" : stream
      @region = [nil, ''].include?(region) ? 'us-west-2' : region
    end

    def report
      if run_status.failed?
        message = {}
        message[:subject]     = "chef-client Run Failed"
        message[:time]        = time.iso8601
        message[:node]        = "Chef run failed on #{node.name}"
        message[:instance_id] = instance_id
        message[:exception]   = run_status.formatted_exception
        message[:backtrace]   = Array(backtrace).join('\n')

        file = Tempfile.new('dumblog-chef')
        begin
          file.write message.to_json
          file.flush
          `for i in {1..5}; do dumblog -group #{group} -stream #{stream} -region #{region} $(cat #{file.path}) && break || sleep 15; done`
        ensure
          file.close
          file.unlink
        end
      end
    end
  end
end
