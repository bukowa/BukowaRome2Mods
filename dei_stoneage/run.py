import os


def change_building_time_and_upkeep():
    files = os.listdir('db/building_levels_tables_original')

    # read all files
    content = {}
    for file in files:
        with open(f'db/building_levels_tables_original/{file}', 'r') as f:
            content[file] = f.read()


    for k, v in content.items():
        lines = v.split('\n')
        new_lines = []
        for i, line in enumerate(lines):
            if i <= 1:
                new_lines.append(line)
                continue
            if line:
                line = line.split('\t')
                line[4] = str(int(line[4]) * 5)
                line[5] = str(int(line[5]) * 10)
                new_lines.append('\t'.join(line))
            else:
                new_lines.append(line)

        content[k] = '\n'.join(new_lines)

        # save the new content to a new file but in different directory
        with open(f'db/building_levels_tables/{k}', 'w') as f:
            f.write(content[k])

if __name__ == '__main__':
    change_building_time_and_upkeep()