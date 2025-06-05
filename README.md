# Binder

> Binary search on steroids for Game Maker Studio 2.3

Binder is a binary search library for those who need quick, efficient lookups on large datasets in games where lookup performance matters, and linear searches or simple hashmaps just won’t cut it.


## Features

- **Indexing** – Generate multiple ordered indexes of your data without duplicating or modifying it.
- **Multiple results** – Quickly retrieve all matching values from a single search, not just individual hits.
- **Mergeable results** – Easily combine the results of multiple lookups using union and intersection.
- **Automatic sorting** – Binder handles sorting internally so you can focus on searching, not maintaining order.
- **Performant** – Binary search scales with your data, providing fast lookups on any size.
- **Non-intrusive** – Doesn't alter your original dataset.


## Who is this for?

Binder is ideal for:

- Dealing with large datasets that need to be searched through quickly.
- Performing many repeated searches over the same, static, dataset.
- Searching through the same data in multiple ways.

It may not be for you if:

- Your data is dynamic / changes frequently.
- You need to perform lookups based on just single field (consider a struct).
- Your lookup relies on a condition that can not be solved by a binary search, like full text search.


## How to use

See the [Wiki](https://github.com/homunculus84/binder/wiki) for installation, usage examples, and API details.

