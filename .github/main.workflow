workflow "Build and Publish" {
  on = "push"
  resolves = ["publish"]
}

action "Publish" {
  uses = "actions/action-builder/shell@master"
  runs = "make"
  args = "publish"
  secrets = ["GITHUB_TOKEN"]
}
