from datetime import datetime
from mkdocs.config.defaults import MkDocsConfig

def on_config(config: MkDocsConfig) -> MkDocsConfig:
    if not config.copyright:
        raise ValueError("The `copyright` option is not specified in mkdocs.yml!")

    start_year = 2025
    year = datetime.now().year

    if year == start_year:
        config.copyright = config.copyright.format(year=str(year))
    else:
        config.copyright = config.copyright.format(year=f"{start_year} - {year}")

    return config
