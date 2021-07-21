.PHONY: all clean fetch index package upload

all: index

fetch:
	./scripts/fetch.sh

package: fetch
	./scripts/package.sh

upload: package
	cr upload -o 3h4x -r istio-charts -p packages --skip-existing

index: upload
	cr index -o 3h4x -r istio-charts -p packages -i index.yaml -c https://comocomo.github.io/istio-charts

clean:
	rm -fr charts packages
