<h1 align="center">Regülar.io</h1>

<p align="center">
  <br>
  <img src="https://github.com/Xavier-IV/regeular_io/assets/14009259/a733db1e-ffbc-4e7f-87ed-105f13443ae4" alt="regeular-logo" width="120px" height="120px"/>
  <br>
  <br>
  <em>Keep track of your regular customer, reward them and<br/>grow your business!</em>
  <br>
</p>

<p align="center">
  <a href="https://regeular.io"><strong>regeular.io</strong></a>
  <br>
</p>

<p align="center">
  <a href="LICENSE">License</a>
  ·
  <a href="https://github.com/Xavier-IV/regeular_io/issues">Submit an Issue</a>
  <br>
  <br>
</p>


https://github.com/Xavier-IV/regeular_io/assets/14009259/81933259-8e07-4f1b-8495-17de1ec089a5


## Requirement

- Ruby 3.2.0
- Postgres 16

It is recommended to install `rbenv` ahead.

## Setup

For Terraform release, you can take a look at: https://github.com/Xavier-IV/regeular_io.terraform

Head over to `config/credentials/example.yml` on how to setup your envs.
At minimum, you should have generated `development` env.

```bash
$ bin/rails db:prepare
$ bin/dev
```

## Contributing

```bash
# Lint
$ rubocop -A
```

---

Copyright 2023 Regülar
