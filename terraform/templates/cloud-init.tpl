#cloud-config

# upgrade packages on boot
package_update: true
package_upgrade: false
package_reboot_if_required: false

write_files:
  - path: /etc/ssh/sshd_config
    content: |
         # manged by cloud-init
         AddressFamily any
         Port 22
         
         #HostKey /etc/ssh/ssh_host_dsa_key
         #HostKey /etc/ssh/ssh_host_ecdsa_key
         AcceptEnv LC_*
         Banner none
         ChallengeResponseAuthentication no
         Ciphers aes256-gcm@openssh.com,aes128-gcm@openssh.com
         #ClientAliveCountMax 0
         #ClientAliveInterval 900
         Compression no
         HostKey /etc/ssh/ssh_host_rsa_key
         HostKey /etc/ssh/ssh_host_ed25519_key
         HostbasedAuthentication no
         IgnoreRhosts yes
         KexAlgorithms curve25519-sha256@libssh.org,ecdh-sha2-nistp384,ecdh-sha2-nistp521 
         LogLevel VERBOSE
         MACs hmac-sha2-512-etm@openssh.com,hmac-sha2-256-etm@openssh.com
         MaxAuthTries 2
         MaxSessions 10
         MaxStartups 10:30:100
         PasswordAuthentication no
         PermitEmptyPasswords no
         PermitRootLogin without-password
         PrintMotd no
         Protocol 2
         Subsystem sftp /usr/lib/openssh/sftp-server
         SyslogFacility AUTHPRIV
         UseDNS no
         UsePAM yes
         X11Forwarding no

# only run
runcmd:
  - "systemctl restart sshd"
  - "touch /etc/cloud-init.done"

final_message: "The system is finally up, after $UPTIME seconds"

#phone_home:
# url: http://my.example.com/$INSTANCE_ID/
# post: [ pub_key_dsa, pub_key_rsa, pub_key_ecdsa, instance_id ]
