name: CompatHelper
on:
  schedule:
    - cron: 0 0 * * *
  workflow_dispatch:
permissions:
  contents: write
  pull-requests: write
jobs:
  CompatHelper:
    runs-on: ubuntu-latest
    steps:
      - name: Check if Julia is already available in the PATH
        id: julia_in_path
        run: which julia
        continue-on-error: true
      - name: Install Julia, but only if it is not already available in the PATH
        uses: julia-actions/setup-julia@v1
        with:
          version: '1'
          arch: ${{ runner.arch }}
        if: steps.julia_in_path.outcome != 'success'
      - name: "Add the General registry via Git"
        run: |
          import Pkg
          ENV["JULIA_PKG_SERVER"] = ""
          Pkg.Registry.add("General")
        shell: julia --color=yes {0}
      - name: "Install CompatHelper"
        run: |
          import Pkg
          name = "CompatHelper"
          uuid = "aa819f21-2bde-4658-8897-bab36330d9b7"
          version = "3"
          Pkg.add(; name, uuid, version)
        shell: julia --color=yes {0}
      - name: "Run CompatHelper"
        run: |
          import CompatHelper
          CompatHelper.main()
        shell: julia --color=yes {0}
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
          COMPATHELPER_PRIV: ${{ secrets.DOCUMENTER_KEY }}
          # COMPATHELPER_PRIV: ${{ secrets.COMPATHELPER_PRIV }}
      
