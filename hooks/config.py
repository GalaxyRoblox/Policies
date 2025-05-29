from datetime import datetime
from os import getenv

from mkdocs.config.defaults import MkDocsConfig


def on_config(config: MkDocsConfig) -> MkDocsConfig:
    config.site_url = getenv("MKDOCS_SITE_URL", config.site_url)
    config.repo_name = getenv("MKDOCS_REPO_NAME", config.repo_name)
    config.repo_url = getenv("MKDOCS_REPO_URL", config.repo_url)
    config.edit_uri = getenv("MKDOCS_EDIT_URI", config.edit_uri)

    if not config.copyright:
        raise ValueError("The `copyright` option is not specified in mkdocs.yml!")

    start_year = 2025
    year = datetime.now().year

    if year == start_year:
        config.copyright = config.copyright.format(year=str(year))
    else:
        config.copyright = config.copyright.format(year=f"{start_year} - {year}")

    return config
