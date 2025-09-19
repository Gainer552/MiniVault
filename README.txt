MiniVault

Description
This script creates, mounts, and manages an encrypted container
file on any partition without modifying or repartitioning disks.
It is intended for users who want a quick way to set up an
AES-256 encrypted directory for sensitive files.


Features
- Creates a file-based LUKS2 container with AES-256 encryption.
- Prompts the user for container size, directory name, and password.
- Formats the container with ext4 and mounts it automatically.
- Provides strong defaults: LUKS2, AES-XTS-plain64, Argon2id KDF.
- Mount options include nodev, nosuid, noexec for extra safety.


Usage
1. Make the script executable: chmod +x mini_vault.sh
2. Run as root (or with sudo): sudo ./mini_vault.sh
3. The script will prompt you for:
   - Container size (e.g. 5G, 20G)
   - Directory name (the mountpoint will be created under $HOME).
   - A password to secure the container.
4. Once complete, your secure directory will be mounted at: ~/DIRECTORY_NAME


Unmounting and Closing
To unmount the container and close it:

   - sudo umount ~/DIRECTORY_NAME
   - sudo cryptsetup luksClose DIRECTORY_NAME_crypt

After unmounting and closing, the directory becomes an empty
folder and the container file remains on disk.


Deleting the Container
If you no longer need the container:

   1. Ensure it is unmounted and closed (see above).
   2. Remove the empty mountpoint: rmdir ~/DIRECTORY_NAME
   3. Delete the container file: rm ~/DIRECTORY_NAME.img

For secure deletion, use:
   shred -u ~/DIRECTORY_NAME.img

Requirements
The following utilities must be installed:
- cryptsetup
- fallocate (or dd)
- mkfs.ext4
- mount / umount

On Arch Linux, you can install missing tools with: sudo pacman -S cryptsetup util-linux e2fsprogs


Important Notes
- If you forget the container password, the data is unrecoverable.
- Do not attempt to run the script directly on a block device
  (e.g. /dev/sda), it is designed to work with container files.
- The script only affects the container file and the directory
  you specify. It does NOT overwrite or reformat your OS or
  partitions.


Legal Disclaimer
THIS SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.

USE THIS SCRIPT AT YOUR OWN RISK. YOU ARE RESPONSIBLE FOR
ENSURING YOU DO NOT LOSE DATA, OVERWRITE IMPORTANT FILES, OR
LOCK YOURSELF OUT OF ENCRYPTED CONTAINERS.
