import { fastify } from "fastify";
import { fastifyConnectPlugin } from "@connectrpc/connect-fastify";
import fastifyCors from '@fastify/cors';
import type { FastifyCorsOptions } from '@fastify/cors';

import http from "http";

import express from "express";
import { expressConnectMiddleware } from "@connectrpc/connect-express";

import type { ConnectRouter } from "@connectrpc/connect";
import { BookingStatus, TravelService, type Activity, type Destination } from "../proto/v1/data_pb";
import { load } from "./types";

let routes = (router: ConnectRouter,
    deps: { destinations: Destination[]; activities: Activity[] }
) => {
    const { destinations, activities } = deps;

    return router.service(
        TravelService,
        {
            async getDestination(req, ctx) {
                const dest = destinations.find((d) => d.ref === req.ref);
                if (!dest) {
                    throw new Error(`Destination not found: ${req.ref}`);
                }
                ctx.responseHeader.set("Travel-Version", "v1");
                return dest;
            },

            async searchDestinations(req) {
                const keyword = req.ref?.toLowerCase?.() ?? "";
                const matches = destinations.filter((d) =>
                    d.name.toLowerCase().includes(keyword)
                );
                return { destinations: matches };
            },

            async listDestinations(_req) {
                return { destinations: deps.destinations };
            },

            async createDestination(req) {
                deps.destinations.push(req.destination!);
                return req.destination!;
            },

            async updateDestination(req) {
                const idx = deps.destinations.findIndex((d) => d.ref === req.destination?.ref);
                if (idx === -1) throw new Error(`Destination not found: ${req.destination?.ref}`);
                deps.destinations[idx] = req.destination!;
                return req.destination!;
            },

            async deleteDestination(req) {
                const idx = deps.destinations.findIndex((d) => d.ref === req.ref);
                if (idx === -1) throw new Error(`Destination not found: ${req.ref}`);
                deps.destinations.splice(idx, 1);
                return {};
            },

            async getActivity(req) {
                const act = deps.activities.find((a) => a.ref === req.ref);
                if (!act) throw new Error(`Activity not found: ${req.ref}`);
                return act;
            },

            async listActivities(_req) {
                return { activities: deps.activities };
            },

            async createActivity(req) {
                deps.activities.push(req.activity!);
                return req.activity!;
            },

            async updateActivity(req) {
                const idx = deps.activities.findIndex((a) => a.ref === req.activity?.ref);
                if (idx === -1) throw new Error(`Activity not found: ${req.activity?.ref}`);
                deps.activities[idx] = req.activity!;
                return req.activity!;
            },

            async deleteActivity(req) {
                const idx = deps.activities.findIndex((a) => a.ref === req.ref);
                if (idx === -1) throw new Error(`Activity not found: ${req.ref}`);
                deps.activities.splice(idx, 1);
                return {};
            },

            async bookDestination(req) {
                const exists = deps.destinations.some((d) => d.ref === req.userId);
                if (!exists) throw new Error(`Cannot book. Destination not found: ${req.userId}`);
                return {
                    bookingId: "true",
                    status: BookingStatus.COMPLETED,
                };
            },

        });
};

void main();
async function main() {
    const server = fastify();

    const { destinations, activities } = await load();

    await server.register(fastifyConnectPlugin, {
        routes: (router) => routes(router, { destinations, activities }),
    });

    await server.register(fastifyCors, {
        origin: "*", // Or your actual origin
        methods: ["GET", "POST", "OPTIONS"],
        allowedHeaders: ["Content-Type", "Custom-Request-Header"],
        exposedHeaders: ["Custom-Response-Header", "Trailer-Response-Id"],
        credentials: true,
        maxAge: 2 * 60 * 60,
    });

    server.get("/", (_, reply) => {
        reply.type("text/plain");
        reply.send("Hello World!");
    });
    await server.listen({ host: "localhost", port: 8080 });
    console.log("server is listening at", server.addresses());
}
