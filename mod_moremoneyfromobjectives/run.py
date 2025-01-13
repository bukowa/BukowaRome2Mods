import os
import re
import subprocess
from pathlib import Path


def change_mission_money_rewards(source_root, destination_root, x):

    def change_mission_money_reward(source_file, destination_file):

        with open(source_file, 'r') as file_source:
            content = file_source.read()
            pattern = r"money (\d+);"
            new_content = re.sub(pattern, lambda match: f"money {int(match.group(1)) * x};", content)

            with open(destination_file, 'w') as file_destination:
                file_destination.write(new_content)

    for root, dirs, files in os.walk(source_root):
        for file in files:
            if file == 'missions.txt':
                _source_path = os.path.join(root, file)
                path = Path(_source_path)
                _destination_path = os.path.join(destination_root, *path.parts[1:])
                change_mission_money_reward(_source_path, _destination_path)


def create_pack(pack_filename, destination_root):
    subprocess.run(["rpfm_cli", "--game", "rome_2", "pack", "create", "--pack-path", pack_filename])
    subprocess.run(["rpfm_cli", "--game", "rome_2", "pack", "add", "--pack-path", pack_filename, "--folder-path", destination_root+";"+"campaigns"])



if __name__ == '__main__':
    for i in range(2, 6):
        change_mission_money_rewards("campaigns_source", "campaigns_destination", i)
        create_pack(f"{i}x_money_from_objectives.pack", "campaigns_destination")