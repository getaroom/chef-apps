describe_recipe "apps::capistrano" do
  include MiniTest::Chef::Assertions
  include MiniTest::Chef::Context
  include MiniTest::Chef::Resources

  describe "www app" do
    describe "deploy_to directory" do
      let(:dir) { directory "/srv/www" }

      it "exists" do
        dir.must_exist
      end

      it "is owned by www/www" do
        dir.must_have :owner, "www"
        dir.must_have :group, "www"
      end

      it "is mode 755" do
        dir.must_have :mode, "755"
      end
    end

    describe "releases directory" do
      let(:dir) { directory "/srv/www/releases" }

      it "exists" do
        dir.must_exist
      end

      it "is owned by www/www" do
        dir.must_have :owner, "www"
        dir.must_have :group, "www"
      end

      it "is mode 775" do
        dir.must_have :mode, "775"
      end
    end

    describe "shared directory" do
      let(:dir) { directory "/srv/www/shared" }

      it "exists" do
        dir.must_exist
      end

      it "is owned by www/www" do
        dir.must_have :owner, "www"
        dir.must_have :group, "www"
      end

      it "is mode 775" do
        dir.must_have :mode, "775"
      end
    end

    describe "shared/config directory" do
      let(:dir) { directory "/srv/www/shared/config" }

      it "exists" do
        dir.must_exist
      end

      it "is owned by www/www" do
        dir.must_have :owner, "www"
        dir.must_have :group, "www"
      end

      it "is mode 775" do
        dir.must_have :mode, "775"
      end
    end

    describe "shared/log directory" do
      let(:dir) { directory "/srv/www/shared/log" }

      it "exists" do
        dir.must_exist
      end

      it "is owned by www/www" do
        dir.must_have :owner, "www"
        dir.must_have :group, "www"
      end

      it "is mode 775" do
        dir.must_have :mode, "775"
      end
    end

    describe "shared/pids directory" do
      let(:dir) { directory "/srv/www/shared/pids" }

      it "exists" do
        dir.must_exist
      end

      it "is owned by www/www" do
        dir.must_have :owner, "www"
        dir.must_have :group, "www"
      end

      it "is mode 775" do
        dir.must_have :mode, "775"
      end
    end

    describe "shared/system directory" do
      let(:dir) { directory "/srv/www/shared/system" }

      it "exists" do
        dir.must_exist
      end

      it "is owned by www/www" do
        dir.must_have :owner, "www"
        dir.must_have :group, "www"
      end

      it "is mode 775" do
        dir.must_have :mode, "775"
      end
    end
  end

  describe "princess app" do
    describe "deploy_to directory" do
      it "does not exist" do
        directory("/srv/princess").wont_exist
      end
    end
  end
end
