import { readFile } from "fs/promises";
import path from "path";

import type { ConnectRouter } from "@connectrpc/connect";
import { TravelService, type Activity, type Destination } from "../proto/v1/data_pb";



export async function load(): Promise<{
    activities: Activity[];
    destinations: Destination[];
}> {
    const activityPath = path.resolve(__dirname, "../../../assets/activities.json");
    const activityData = await readFile(activityPath, "utf-8");

    const activities: Activity[] = JSON.parse(activityData);

    const destinationPath = path.resolve(__dirname, "../../../assets/destinations.json");
    const destinationData = await readFile(destinationPath, "utf-8");

    const destinations: Destination[] = JSON.parse(destinationData);

    return { activities, destinations };
}