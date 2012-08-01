describe_recipe "apps::env" do
  include MiniTest::Chef::Assertions
  include MiniTest::Chef::Context
  include MiniTest::Chef::Resources

  describe "/etc/environment" do
    let(:environment) { file "/etc/environment" }

    describe "MERB_ENV" do
      it "is set to the framework_environment" do
        environment.must_include %{MERB_ENV="#{node['framework_environment']}"}
      end

      it "doesn't appear more than once" do
        environment.wont_match /MERB_ENV.*MERB_ENV/
      end
    end

    describe "RACK_ENV" do
      it "is set to the framework_environment" do
        environment.must_include %{RACK_ENV="#{node['framework_environment']}"}
      end

      it "doesn't appear more than once" do
        environment.wont_match /RACK_ENV.*RACK_ENV/
      end
    end

    describe "RAILS_ENV" do
      it "is set to the framework_environment" do
        environment.must_include %{RAILS_ENV="#{node['framework_environment']}"}
      end

      it "doesn't appear more than once" do
        environment.wont_match /RAILS_ENV.*RAILS_ENV/
      end
    end
  end
end
