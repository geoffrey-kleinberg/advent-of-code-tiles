import os

for year in range (2015, 2025):
    for day in range(1, 26):
        if os.path.exists(f'../advent-of-code/advent-of-code-{year}/12-{str(day).zfill(2)}-{str(year)[2:]}/main.rb'):
            if not os.path.isdir(f'advent-of-code-{year}/12-{str(day).zfill(2)}-{str(year)[2:]}'):
                os.system(f'mkdir advent-of-code-{year}/12-{str(day).zfill(2)}-{str(year)[2:]}')
            os.system(f'cp ../advent-of-code/advent-of-code-{year}/12-{str(day).zfill(2)}-{str(year)[2:]}/main.rb advent-of-code-{year}/12-{str(day).zfill(2)}-{str(year)[2:]}')