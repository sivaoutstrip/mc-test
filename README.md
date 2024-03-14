## People / Person Model

### Attributes

* Name *
* Age
* Title 

has many details, accepts nested attributes, dependent destroy, allow nil and destroy

## Details Model

### Attributes

* Email *
* Phone

belongs to person

# For test coverage

* rails test test/controllers
* rails test test/models

`open coverage/index.html`