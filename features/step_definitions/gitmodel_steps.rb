Given /^The GitModel database is indexed$/ do
  GitModel.index!(GitModel.default_branch)
end
