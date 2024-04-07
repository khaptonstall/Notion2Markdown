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
> Pagination and retrieving child blocks are currently unsupported.

## Getting Started

### Create a Notion Integration
In order for Notion2Markdown to have access to your Notion account, you must first set up a new Internal Integration, which can be done on the [My Integrations page](https://www.notion.so/my-integrations).

Note: You only need to ensure the **Read Content** box is checked under the Capabilities for your integration.

Now you need to connect a Database to your new Integration.

Back in the Notion app, go to your Database, select the ⋯ button in the top-right, then select "Connect to" and choose your new Integration. (If your Integration isn't displayed, try refreshing Notion.)