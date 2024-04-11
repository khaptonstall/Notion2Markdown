# Notion2Markdown

Notion2Markdown is a Swift CLI tool used to query select Notion Databases and convert Pages within them to markdown.

## Features
Notion2Markdown supports converting the following Notion Block types:
- [x] Bookmark
- [x] Bulleted list item
- [x] Callout
- [x] Code
- [x] Divider
- [x] Embed
- [x] Equation 
- [x] Headings
- [x] Numbered list item
- [x] Paragraph
- [x] Quote
- [x] Todo

For a full list of Notion block types, visit their [API Documentation.](https://developers.notion.com/reference/block#block-type-objects)

> [!IMPORTANT]  
> notion2markdown does not currently support fetching nested child blocks

## Prerequisites

### Create a Notion Integration
In order for Notion2Markdown to have access to your Notion account, you must first set up a new Internal Integration, which can be done on the [My Integrations page](https://www.notion.so/my-integrations).

Note: You only need to ensure the **Read Content** box is checked under the Capabilities for your integration.

### Connect a Database to your Integration
Now you need to connect a Database to your new Integration.

Back in the Notion app, go to your Database, select the ⋯ button in the top-right, then select "Connect to" and choose your new Integration. (If your Integration isn't displayed, try refreshing Notion.)

## Installation

### [Mint](https://github.com/yonaskolb/mint)
To install `notion2markdown` and link it globally:
```bash
mint install khaptonstall/notion2markdown
```

Alternatively, you can add `notion2markdown` to your [Mintfile](https://github.com/yonaskolb/Mint#mintfile). Running `mint install` in the same directory will then install all Swift packages in your Mintfile without linking them globally.

In your Mintfile:
```
khaptonstall/notion2markdown@0.1.0
```

then you can run:
```bash
mint install
```

## Usage
To use `notion2markdown`, you'll need both your Notion Integration token and the identifier of the Database you wish to search in. (See [Notion documentation](https://developers.notion.com/reference/retrieve-a-database) on how to find your Database ID.) Then you can run the following command:
```bash
mint run notion2markdown \
--notion-token <your-notion-token> \
--database-id <your-database-id>
```

Additionally, if you wish to save the markdown to a local file, supply the `--output-directory` option:
```bash
mint run notion2markdown \
--notion-token <your-notion-token> \
--database-id <your-database-id> \
--output-directory <your-output-directory> \
```