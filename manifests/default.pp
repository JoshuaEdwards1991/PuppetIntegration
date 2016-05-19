

file {"/tmp/helloworld":
  ensure => "present",
  content => "Hello World!",
}