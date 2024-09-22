// Copyright © 2024 Kyle Haptonstall. All rights reserved.

import Foundation
import NotionSwift

enum MockData {
    static let pageTitle = "Testing"

    // MARK: Numbered Lists

    static let numberedListBlocks: [ReadBlock] = [
        .mocked(type: .numberedListItem([.mocked(string: "Item 1")])),
        .mocked(type: .numberedListItem([.mocked(string: "Item 2")])),
        .mocked(type: .paragraph([.mocked(string: "Paragraph")])),
        .mocked(type: .numberedListItem([.mocked(string: "Item 1")])),
        .mocked(type: .numberedListItem([.mocked(string: "Item 2")])),
    ]

    static let numberedListMarkdown: String = """
    # \(pageTitle)

    1. Item 1

    1. Item 2

    Paragraph

    1. Item 1

    1. Item 2
    """

    // MARK: Bulleted List Item

    static let bulletedListItemBlocks: [ReadBlock] = [
        .mocked(type: .bulletedListItem([.mocked(string: "Plaintext list item")])),
        .mocked(type: .bulletedListItem([.mocked(string: "Bold list item", annotations: .bold)])),
        .mocked(type: .bulletedListItem([.mocked(string: "Italic list item", annotations: .italic)])),
        .mocked(type: .bulletedListItem([.mocked(string: "Strikethrough list item", annotations: .strikethrough)])),
        .mocked(type: .bulletedListItem([.mocked(string: "Code list item", annotations: .code)])),
    ]

    static let bulletedListItemMarkdown: String = """
    # \(pageTitle)

    - Plaintext list item

    - **Bold list item**

    - *Italic list item*

    - ~~Strikethrough list item~~

    - `Code list item`
    """

    // MARK: Callouts

    static let calloutBlocks: [ReadBlock] = [
        .mocked(type: .callout([.mocked(string: "Plaintext callout")])),
        .mocked(type: .callout([.mocked(string: "Bold callout", annotations: .bold)])),
        .mocked(type: .callout([.mocked(string: "Italic callout", annotations: .italic)])),
        .mocked(type: .callout([.mocked(string: "Strikethrough callout", annotations: .strikethrough)])),
        .mocked(type: .callout([.mocked(string: "Code callout", annotations: .code)])),
    ]

    static let calloutMarkdown: String = """
    # \(pageTitle)

    > Plaintext callout

    > **Bold callout**

    > *Italic callout*

    > ~~Strikethrough callout~~

    > `Code callout`
    """

    // MARK: Code

    static let codeBlocks: [ReadBlock] = [
        .mocked(type: .code([.mocked(string: "let foo = \"bar\"")], language: "Swift")),
        .mocked(type: .code([.mocked(string: "No language defined")])),
    ]

    static let codeMarkdown: String = """
    # \(pageTitle)

    ```Swift
    let foo = "bar"
    ```

    ```
    No language defined
    ```
    """

    // MARK: Embed

    static let embedBlocks: [ReadBlock] = [
        .mocked(type: .embed(url: "nocaption.com", caption: [])),
        .mocked(type: .embed(url: "caption.com", caption: [.mocked(string: "This is a link caption")])),
    ]

    static let embedMarkdown: String = """
    # \(pageTitle)

    [](nocaption.com)

    [This is a link caption](caption.com)
    """

    // MARK: Headings

    static let headingBlocks: [ReadBlock] = [
        .mocked(type: .heading1([.mocked(string: "Heading 1")])),
        .mocked(type: .heading2([.mocked(string: "Heading 2")])),
        .mocked(type: .heading3([.mocked(string: "Heading 3")])),
    ]

    static let headingMarkdown: String = """
    # \(pageTitle)

    # Heading 1

    ## Heading 2

    ### Heading 3
    """

    // MARK: Quotes

    static let quoteBlocks: [ReadBlock] = [
        .mocked(type: .quote([.mocked(string: "Plaintext quote")])),
        .mocked(type: .quote([.mocked(string: "Bold quote", annotations: .bold)])),
        .mocked(type: .quote([.mocked(string: "Italic quote", annotations: .italic)])),
        .mocked(type: .quote([.mocked(string: "Strikethrough quote", annotations: .strikethrough)])),
        .mocked(type: .quote([.mocked(string: "Code quote", annotations: .code)])),
    ]

    static let quoteMarkdown: String = """
    # \(pageTitle)

    > Plaintext quote

    > **Bold quote**

    > *Italic quote*

    > ~~Strikethrough quote~~

    > `Code quote`
    """

    // MARK: Todos

    static let todoBlocks: [ReadBlock] = [
        .mocked(type: .toDo([.mocked(string: "Checked")], checked: true)),
        .mocked(type: .toDo([.mocked(string: "Unchecked")], checked: false)),
    ]

    static let todoMarkdown: String = """
    # \(pageTitle)

    - [x] Checked

    - [ ] Unchecked
    """

    // MARK: Images

    static let imageBlocks: [ReadBlock] = [
        .mocked(type: .image(file: .file(url: "https://notion.so/image1.png", expiryTime: .now), caption: [.mocked(string: "Private Image")])),
        .mocked(type: .image(file: .file(url: "https://notion.so/image2.png", expiryTime: .now))),
        .mocked(type: .image(file: .external(url: "https://notion.so/image3.png"), caption: [.mocked(string: "External Image")])),
        .mocked(type: .image(file: .external(url: "https://notion.so/image4.png"))),
    ]

    static let imageMarkdown: String = """
    # \(pageTitle)

    ![Private Image](image1.png)

    ![](image2.png)
    
    ![External Image](https://notion.so/image3.png)

    ![](https://notion.so/image4.png)
    """
}
