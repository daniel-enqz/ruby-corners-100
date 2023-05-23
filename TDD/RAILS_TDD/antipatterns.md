# Antipatterns

## Slow tests
> As applications grow, we will need to be testing more and more stuff. Development can get slow.

### Tricks to find slow tests:
1.Running (--profile 4) will output the 4 slowest tests. You can add this flag to your .rspec file to output with every run.
2.Some tests dont require Rails. Therefore require only "spec_helper" rather than "rails_helper".

