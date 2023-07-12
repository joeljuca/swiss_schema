Code.compile_file("test/support/repo.exs")
Code.compile_file("test/support/create_users.exs")
Code.compile_file("test/support/schema.exs")

ExUnit.start()
