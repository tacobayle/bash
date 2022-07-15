#!/bin/bash
basename "https://portal.avipulse.vmware.com/api/portal/download/SoftwaresDownloads/Version-21.1.4/controller-21.1.4-9210.ova?X-Amz-Algorithm=AWS4-HMAC-SHA" | sed -e 's/.ova.*/.ova/g'