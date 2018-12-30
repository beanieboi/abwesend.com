workflow "Build and Publish" {
  on = "push"
  resolves = ["publish"]
}

action "publish" {
  uses = "actions/action-builder/shell@master"
  runs = "ALLOW_DIRTY=1 bundle exec rake publish"
  secrets = ["GITHUB_TOKEN"]
}
