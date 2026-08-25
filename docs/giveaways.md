# Galaxy Giveaway Policy

The Galaxy Staff Team allows players to request giveaways consisting of ships or credits. These giveaways will be hosted in the [`#!cpp #giveaways`](https://discord.com/channels/204965774618656769/780975200081936432) channel, in the official Discord Server. You can request to start a giveaway by making an Admin Support ticket in the [Support Discord server](https://discord.com/invite/ShWshkhYhZ "Discord - Galaxy Support").

## Restrictions

Giveaways have a few restrictions on giveaway rewards in place to prevent worthless giveaways. All of the rewards for a giveaway will be removed from the donor when the giveaway begins. This includes ship blueprints. __Giveaways cannot be cancelled after they begin, unless authorized by the Admin Director or the Lead Admin.__

- Giveaways may only have one reward, either a ship or credits, and only one winner.
    - If the giveaway is for credits, it can have multiple winners.
- Build Menu ships of the Carrier class or above may be giveaway rewards.
- Advanced ships of the Battleship class or above may be giveaway rewards.
- Limited ships of the Battleship class or above may be giveaway rewards.
    - Limited ships of the Battlecruiser class or below may also be giveaway rewards, but only at an admin's discretion. This will usually only be allowed for particularly rare limiteds, such as the Reaper.
- Credit giveaways are allowed only if the per-winner reward is higher than or equal to 100,000 credits.

## Conditions

Donors may specify some conditions that entrants must satisfy to qualify for the giveaway reward. Entrants who enter the giveaway without meeting these conditions will receive a Giveaway Blacklist according to the [Moderation Guidelines](./moderation.md#giveaway-blacklist "Moderation Guidelines - Giveaway Blacklist"). If an entrant is suspected to be an alternate account, they may be disqualified from the giveaway by an Admin. If an entrant is determined to be an alternate account after a giveaway is processed, it may be reverted and the giveaway rerolled at the Admin Director's or Lead Admin's discretion. Entrants must be verified via Bloxlink.

Conditions will be evaluated by admins prior to accepting a giveaway. If they are considered unfair or otherwise too restrictive or specific, the donor may be asked to change their conditions. Some common conditions are listed below, but donors may submit their own if none of these work for them. Do note that these conditions are still subject to being too restrictive.

- Minimum / Maximum Net Worth
- Minimum / Maximum Carnage
- Minimum / Maximum Reverse Carnage
- Minimum / Maximum Score
- Minimum ROBLOX Account Age
- Minimum Messages in the Discord Server _(prior to the giveaway starting)_

And here are some conditions that admins will not accept. This is not an exhaustive list, rather it is just some examples.

- A minimum of 180,000,000 Carnage
    - Too restrictive. Only four players _(as of writing)_ qualify for this condition.
- Must be named `<specific username>`
    - Obviously too restrictive. Giveaways are giveaways, not ship transfers.
- Must have exactly `<condition>`
    - Too restrictive, same as specific usernames.
- Must `<perform an action>` (i.e. spam pinging a specific Discord user)
    - May qualify as a [Discord Community Guidelines violation](./moderation.md#discord-tos-cg "Moderation Guidelines - Violating Discord Terms of Service / Community Guidelines") on our Discord's part, encouraging members to "harass" another member.

## Starting a Giveaway

This section is to instruct Admins on how to actually start a giveaway. The Galaxy Discord bot is used for giveaways. Run `-gw explain` to see a list of all of the arguments the `-gw adv` command can accept. The following codeblock contains the common flags most giveaways will use.

```ansi
--channel [channel]
--prize [what is being rewarded?]
--duration [use 24h, 1d, 2h30m, etc]
--winners [number, defaults to 1]
--description [use this for requirements]
--emoji [emoji]
--role [role_id] - Restricts the giveaway to a role
--mentions [role_id] - THIS WILL PING ROLES. PLEASE ONLY USE THIS ONCE PER GIVEAWAY SESSION
--image [image_url] - Please include an image when giving away a ship, refer to the Galaxypedia for ship images
--blacklist [role_id] - Blacklists a role from entering the giveaway
```

/// details | Example
    open: True

```ansi
-gw adv --channel 780975200081936432 --prize Cyber Leviathan --duration 24h --blacklist 976726812388376576
--description You must have at least 1,000 messages in the server to qualify for this giveaway. Donated by GuideWriter.
--image https://static.wikitide.net/galaxypediawiki/thumb/3/3e/Galaxy_CyberLevi-Icon.webp/300px-Galaxy_CyberLevi-Icon.webp.png
```

///

*[Net Worth]: Total value of a player's inventory, as shown in /inventory
*[Reverse Carnage]: Total value of ships lost
*[Carnage]: Total value of ships killed
*[Score]: Internal value that can be used to determine how much a player has played the game
