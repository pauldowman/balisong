Balisong: A blog-aware website for coders
-----------------------------------

_[https://github.com/pauldowman/balisong](https://github.com/pauldowman/balisong)_

Balisong believes that:

* A coder should have a website that they hack on and customize.
* The best way to edit website content is with your favorite text editor.
* A static site isn't enough. A lot can be done with JavaScript but sometimes you need some
  server-side functionality.
* Content should be separate from the app and should be deployed/updated
  separately.
* It must be super simple to write content, deploy, and hack on.


Features
--------

* A post or page is [simply a directory of
  files](https://github.com/pauldowman/balisong-sample-db/tree/master/pages/foo/).
  There's a main file (think of it as index.html, but it can be Markdown,
  Textile, HTML, whatever), plus
  included partials, image files, source code files, and downloadable files of
  any type.
  * Text can be written as Markdown, Textile, HTML, plain text or any other
    common markup format.
  * Posts/pages can consist of multiple parts: text, code blocks, and images.
    Parts can be separate files and can be included by each other.
  * Code blocks can be separate source code files so that they can be tested,
    edited with syntax highlighting in your favorite editor, and so that you
    don't have to copy & paste.
    * Code is rendered using syntax highlighting
    * Any partial (i.e. "include" file) can be rendered as code, so you can
      have an HTML partial that gets rendered either as HTML or as source code
      (or both).
* All data is stored using Git (including dynamic data such as comments if/when
  that gets implemented). (It uses
  [GitModel](https://github.com/pauldowman/gitmodel))
  * Content can be edited locally and deployed to the production server using
    Git without redeploying the app.
  * Content can also be pushed to a public repository like GitHub where people
    can follow it for updates and fork it to contribute articles.
  * Backing up the site's data is just "git pull" (no need to bother with
    dumping a database).
  * The site's data can be rolled back to any previous version, and all history
    is kept forever (stored efficiently by Git).
* Easy to hack on and customize
  * Balisong is a Rails 3 app using Haml and Sass
  * Good test coverage with Cucumber and Rspec


Customization
------------

It's a standard Rails app, but you'll want to customize it. The best way to do that is to fork this repo on GitHub. Please do send pull requests for general changes.

Obviously you'll want to customize the look, which is done by editing the files
under /app/views and the files under /public.  

There are also some important configuration options that need changing, such as
the location of the git repo that contains the posts and pages. Search for
CHANGEME comments in the code. (grep -r CHANGEME).


Getting started
---------------

1. Deploy the app somewhere
2. Create a new Git repo for the site content by running `RAILS_ENV=production
   rake balisong:db:create` on the server
3. Edit your content locally and push it to the repo on the server (TODO
   instructions) OR: edit the content on the server in the Git repo that you
   created in step 1 above, and commit it
4. Profit!


Format of pages and posts
-------------------------

The content database (i.e. the Git repo where the page content is stored) has a directory named "pages" at it's root, and inside that it has a directory for each page or post.

There's an example at [https://github.com/pauldowman/balisong-sample-db](https://github.com/pauldowman/balisong-sample-db)

So each page or post is a directory inside CONTENT_ROOT/pages. The directory must contain two files:
1. A file for your article text named "main.ext" where "ext" is one of the
   supported file types ("md", "markdown", "textile", "html", etc.) (TODO list
   supported formats)
2. A file named attributes.json for the article metadata such as title and categories

__The metadata file__

The attributes file is in JSON format, it's content should look something like
this:

    {
        "title": "My favorite bourbons",
        "categories": [ "Alcohol", "Delicious things", "Bourbon", "Whiskey" ]
    }

__The content files__

The main content file ("main.md" or "main.textile", etc.) can include other content files. The syntax looks like this:

    {{ filename | formatter }}
    
The `formatter` argument can often be omitted if it can be guessed by the
filename extension, for example the following are equivalent, and will include
the file named knobcreek.markdown, rendering it as HTML:

    {{ knobcreek.markdown | markdown}}

    {{ knobcreek.markdown}}

But it can also be used to render a file in a different format, for example as
source code. For example, to render the file named knobcreek.html as source
code with syntax highlighting you would do:

    {{ knobcreek.html | code(html)}}

Note that you could also have the following which would simply include the file
as HTML to be rendered normally by the browser:

    {{ knobcreek.html}}

Some more examples:

Ruby code:

    {{whiskey.rb | code(ruby)}}

Plain text files can be rendered in &lt;pre&gt; blocks:

    {{makersmark.txt | text}}

Image files are rendered as images inline in the HTML (i.e. as &lg;img&gt; tags)

    {{bulleit.jpg | image}}

Any type of file can be rendered as a download link, and when clicked the
browser will prompt to download the file instead of displaying it:

    {{archive.zip | download}}

    {{bulleit.jpg | download}}

The included content files can, of course, include other files. (Recursive includes are detected by the app hanging forever or crashing or something, I haven't tried it. Definitely not recommended.)


__Pages vs. Posts__

Blog "posts" are simply pages that have a date as part of the directory name in
the format `YYYY-MM-DD-post-id-string.`

"Posts" have a URL that includes the date, e.g.
http://yourblog.com/2010/11/27/my-favorite-bourbons while normal pages have a
url that is simply the page name, e.g.
http://yourblog.com/my-favorite-bourbons.

Posts (as opposed to Pages) show up in the "Recent posts" list.


Contributors
------------

* [Paul Dowman](http://pauldowman.com/about) ([@pauldowman](http://twitter.com/pauldowman))


To do
-----

* Documentation
* A simple but nice-looking default design
  * HTML 5 boilerplate? https://github.com/himmel/html5-boilerplate
* Atom feed
* Comment support
* Search for TODO in the code and Cucumber features tagged with @wip

