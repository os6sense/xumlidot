
## Rails

Generate rails https://github.com/rails/rails on 24th Feb 2018.

    bin/xumlidot ~/rails > ~/rails.dot

There are still some errors and exceptions - not as many as I had thought though.

    dot -Tsvg rails.dot -o rails.svg

generates the svg.

I find large SVGs very difficult to view (I WILL be adding an option to optimize the connections) although Firefox 
will load them, and the mac image viewer seems to just about cope. Not an endorsement but https://pdfresizer.com/svg-to-pdf
did a great job of converting the svg to pdf although I suspect there are command line options to do the same.

## xumlidot

    bin/xumlidot ~/lib > ~/xumlidot.dot
    dot -Tsvg xumlidot.dot -o xumlidot.svg

xumlidot is pretty small so should be viewable in firefox or ... anything that
can view svg ... it could even be a png, e.g:

    dot -Tpng xumlidot.dot -o xumlidot.png

