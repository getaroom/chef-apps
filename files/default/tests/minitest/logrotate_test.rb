describe_recipe "apps::logrotate" do
  include MiniTest::Chef::Assertions
  include MiniTest::Chef::Context
  include MiniTest::Chef::Resources

  describe "www app" do
    describe "/etc/logrotate.d/www" do
      let(:logrotate) { file "/etc/logrotate.d/www" }
      let(:stat) { File.stat(logrotate.path) }

      it "exists" do
        logrotate.must_exist
      end

      it "is owned by root" do
        assert_equal user("root").uid, stat.uid
        assert_equal group("root").gid, stat.gid
      end

      it "is mode 644" do
        assert_equal "644".oct, (stat.mode & 007777)
      end

      it "rotates the application logs" do
        logrotate.must_include "/srv/www/shared/log/*.log"
      end

      it "rotates daily" do
        logrotate.must_include "daily"
      end

      it "rotated logs are owned by the application" do
        logrotate.must_include "create 664 www www"
      end

      it "keep 30 previous logs" do
        logrotate.must_include "rotate 30"
      end

      it "marks rotated file names with a date" do
        logrotate.must_include "dateext"
      end

      it "compresses the rotates log files" do
        logrotate.must_include "compress"
      end

      it "continues rotating logs if there are no log files to rotate" do
        logrotate.must_include "missingok"
      end

      it "does not rotate empty log files" do
        logrotate.must_include "notifempty"
      end

      it "copies and truncates the original log file" do
        logrotate.must_include "copytruncate"
      end

      it "postpones compression of the previous log file to the next rotation cycle" do
        logrotate.must_include "delaycompress"
      end
    end
  end

  describe "princess app" do
    describe "/etc/logrotate.d/princess" do
      it "does not exist" do
        file("/etc/logrotate.d/princess").wont_exist
      end
    end
  end
end
