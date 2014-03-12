carrierwave-pdf2thumbs
======================

[![Build Status](https://travis-ci.org/eduardomartines/carrierwave-pdf2thumbs.png?branch=master)](https://travis-ci.org/eduardomartines/carrierwave-pdf2thumbs)

It extracts all the PDF pages and creates thumbnails with the specified size. Fully tested with Rspec and also works with Amazon S3. `carrierwave-pdf2thumbs` was originally based on [carrierwave-docsplit](https://github.com/woodbridge/carrierwave-docsplit).

## Getting started

Adding it to your Gemfile:

```ruby
gem 'carrierwave-pdf2thumbs'
```

Including the module:

```ruby
class YourUploader < CarrierWave::Uploader::Base
  include CarrierWave::Pdf2thumbs

  # code omitted
end
```

Using the process method to generate the thumbnails:

```ruby
class YourUploader < CarrierWave::Uploader::Base
  # code omitted

  process pdf2thumbs: [700, nil]
end
```

## Docsplit

We use `Docsplit` to split the PDF pages. To install it just follow the official documentation:

http://documentcloud.github.io/docsplit/

## MIT License

Copyright (c) 2014 Eduardo Martines

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

