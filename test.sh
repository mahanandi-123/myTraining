#!/bin/bash
# List all GCP projects
projects=$(gcloud projects list --format="value(projectId)")
# Loop through each project
for project in $projects; do
  echo "Project: $project"
# List all VM instances in the project
instances=$(gcloud compute instances list --project=$project --format="value(name,zone)")
# Loop through each instance and list the users
while read -r instance zone;
do
  echo " Instance: $instance"
# List the users on the instance
users=$(gcloud compute ssh --project=$project --zone=$zone $instance --command "cut -d: -f1 /etc/passwd" 2>/dev/null)
# Print the users
echo "$users" | while read -r user;
do echo " User: $user"
done
done <<< "$instances" done