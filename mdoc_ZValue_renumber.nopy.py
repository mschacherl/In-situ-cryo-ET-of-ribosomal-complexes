"""
Created on Fri Jul 25 12:41:00 2025

@author: Thiemo Sprink
"""
import os
import sys

def renumber_zvalue_blocks(filepath):
    # Write backup
    backup_path = filepath.replace(".mdoc", "_bu.mdoc")
    os.rename(filepath, backup_path)

    with open(backup_path, 'r') as f:
        content = f.read()

    # Separate blocks according to empty line
    blocks = content.strip().split('\n\n')

    new_blocks = []
    z_counter = 0

    for block in blocks:
        lines = block.strip().splitlines()
        if lines and lines[0].strip().startswith("[ZValue"):
            # Erste Zeile ersetzen durch neuen ZValue
            lines[0] = f"[ZValue = {z_counter}]"
            z_counter += 1
        new_blocks.append('\n'.join(lines))

    # Compile with a double line break
    new_content = '\n\n'.join(new_blocks) + '\n'

    with open(filepath, 'w') as f:
        f.write(new_content)

    print(f"✓ {os.path.basename(filepath)}: {z_counter} ZValues renumbered. Backup: {os.path.basename(backup_path)}")


# Optional: Apply to a directory
def process_mdoc_folder(folder_path):
    for fname in os.listdir(folder_path):
        if fname.endswith(".mdoc") and not fname.endswith("_bu.mdoc"):
            renumber_zvalue_blocks(os.path.join(folder_path, fname))


# Command line interface
if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Use:\n  python script.py /path/to/mdoc_file\n or:\n  python script.py /path/to/folder")
        sys.exit(1)

    path = sys.argv[1]

    if os.path.isfile(path):
        renumber_zvalue_blocks(path)
    elif os.path.isdir(path):
        process_mdoc_folder(path)
    else:
        print("❌ Path not found.")
