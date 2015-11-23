# Oct

An alternative way of managing Hex dependencies for a Mix project.

## Description

This is a very quick **proof of concept** for some Mix tasks to automatically add named dependencies to your project.

As someone just starting out with Elixir I am often making small Mix projects, and adding the packages I want is not as straightforward as it could be. This allows packages to be added through a terminal mix task invocation, as one would expect from other package managers (`gem`, `npm`, `bower`, etc.).

## Installation

After cloning the package is made available globally (in `~/.mix/archives`) by running:

   `mix install`

## Usage

Once installed there will be two new mix tasks available to all projects:

  - `mix oct.init` – reads your projects currently listed dependencies and creates a new `Octfile`.
  - `mix oct.install «package» [«version»]` – adds the named package to your package’s `Octfile` (if no version is specified the latest version number will be found and used).

To start using `Oct` for your project, simply change the `deps: deps` line in your mix file to read `deps: Oct.deps`.

## How it works

The functionality is intentionally kept quite simple and does not try to be smart. The list of packages is moved into a simple text file, which we pass off to Mix after converting into the normal list format.

Using `mix oct.install «package»` will simply check the package info in Hex to find the latest version and add a line to the project `Octfile`. Again, the task of actually fetching and installing the package is left in the hands of `mix deps.get`, as normal.

