import re

pattern = re.compile(r"\[[^\]]*]\(\s*(?P<url>[^)\s]+)(?:\s+[\"'][^\"']*[\"'])?\s*\)")


def on_page_markdown(
    markdown: str,
    *,
    page: object,  # pyright: ignore[reportUnusedParameter]
    config: object,  # pyright: ignore[reportUnusedParameter]
    files: object,  # pyright: ignore[reportUnusedParameter]
) -> str:
    def replacer(match: re.Match[str]) -> str:
        full_match = match.group(0)
        url = str(match.group("url"))

        if "://" in url or not url.startswith(("#", "./")):
            return full_match

        new_url = url.replace("--", "-")
        return full_match.replace(url, new_url, 1)

    return re.sub(pattern, replacer, markdown)
