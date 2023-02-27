main: parent clean
	./jemdoc -c site.conf src/*.jemdoc
	mv src/*.html html/
	./jemdoc -c site.conf src/blog/*.jemdoc
	mv src/blog/*.html html/
	open html/index.html

parent:
	mkdir -p html
	cp jemdoc.css html/jemdoc.css

clean:
	rm -f html/*.html
