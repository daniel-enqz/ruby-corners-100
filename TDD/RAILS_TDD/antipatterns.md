# Antipatterns

## Slow tests
> As applications grow, we will need to be testing more and more stuff. Development can get slow.

### Tricks to find slow tests:
1. Running (--profile 4) will output the 4 slowest tests. You can add this flag to your .rspec file to output with every run. <br>
2. Some tests dont require Rails. Therefore require only "spec_helper" rather than "rails_helper".
3. Only persist if necessary. Persisting to the database takes far longer than initializing objects in memory.
4. Use happy paths for feture specs, do not over complicate adding sad paths. Find a balance in feature specs.
5. Stub external APIS, do not hit them directly. (You can configure to test the API driectly on CI only)

