# LiveViewExample

Phoenix LiveView Example

## Requirements

[asdf]

## Start server

Install dependencies

```bash
mix setup
```

Start server

```bash
mix phx.server
```

## Setup for editing

Install asdf plugins

```bash
asdf plugin-add elixir \
  ; asdf plugin-add erlang \
  ; asdf plugin-add nodejs \
  ; asdf plugin-add python
```

Install languages

```bash
asdf install
```

Install dependencies

```bash
npm install && pip install --requirement requirements.txt
```

Setup pre-commit

```bash
pre-commit install
```

[asdf]: https://github.com/asdf-vm/asdf
