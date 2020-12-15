# deepl-cui-swift

CUI wrapper for the [Translating text API of DeepL](https://www.deepl.com/docs-api/translating-text/request/).

## help

```
USAGE: command [<text>] [--source-lang <source-lang>] [--target-lang <target-lang>] [--auth-key <auth-key>]

ARGUMENTS:
  <text>                  Text to be translated. If not specified, use STDIN. 

OPTIONS:
  -s, --source-lang <source-lang>
                          Language of the text to be translated. If this
                          parameter is omitted, the API will attempt to detect
                          the language of the text and translate it. 
  -t, --target-lang <target-lang>
                          The language into which the text should be translated
                          (default: EN-US)
  --auth-key <auth-key>   authKey for DeepL API. If not specified, use the
                          environment variable DEEPL_AUTH_KEY. 
  -h, --help              Show help information.
```

