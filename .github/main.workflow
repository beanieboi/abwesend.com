workflow "Build and Publish" {
  on = "push"
  resolves = ["publish"]
}

action "publish" {
  uses = "bash"
  runs = "ALLOW_DIRTY=1 bundle exec rake publish"
}
