package main

import (
	"context"
	"fmt"
	"net/http"
	"strings"

	connectcors "connectrpc.com/cors"
	"github.com/rs/cors"

	"connectrpc.com/connect"
	v1 "github.com/codeharik/moonspace/proto/v1"
	"github.com/codeharik/moonspace/proto/v1/spacev1connect"
	"golang.org/x/net/http2"
	"golang.org/x/net/http2/h2c"
)

type TravelServer struct {
	activities   []*v1.Activity
	destinations []*v1.Destination
}

func (s *TravelServer) GetDestination(
	ctx context.Context,
	req *connect.Request[v1.GetDestinationRequest],
) (*connect.Response[v1.Destination], error) {
	ref := req.Msg.Ref
	for _, dest := range s.destinations {
		if dest.Ref == ref {
			resp := connect.NewResponse(dest)
			resp.Header().Set("Travel-Version", "v1")
			return resp, nil
		}
	}

	return nil, connect.NewError(connect.CodeNotFound, fmt.Errorf("destination not found: %s", ref))
}

func (s *TravelServer) SearchDestinations(ctx context.Context, req *connect.Request[v1.GetDestinationRequest]) (*connect.Response[v1.ListDestinationsResponse], error) {
	keyword := strings.ToLower(req.Msg.Ref)
	matching := make([]*v1.Destination, 0)

	fmt.Println(keyword)

	for _, dest := range s.destinations {
		if strings.Contains(strings.ToLower(dest.Name), keyword) {
			matching = append(matching, dest)
		}
	}

	resp := connect.NewResponse(&v1.ListDestinationsResponse{
		Destinations: matching,
	})
	return resp, nil
}

func (s *TravelServer) ListDestinations(ctx context.Context, req *connect.Request[v1.ListDestinationsRequest]) (*connect.Response[v1.ListDestinationsResponse], error) {
	resp := connect.NewResponse(&v1.ListDestinationsResponse{
		Destinations: s.destinations,
	})
	return resp, nil
}

func (s *TravelServer) CreateDestination(ctx context.Context, req *connect.Request[v1.CreateDestinationRequest]) (*connect.Response[v1.Destination], error) {
	newDest := req.Msg.Destination
	for _, d := range s.destinations {
		if d.Ref == newDest.Ref {
			return nil, connect.NewError(connect.CodeAlreadyExists, fmt.Errorf("destination with ref %s already exists", d.Ref))
		}
	}
	s.destinations = append(s.destinations, newDest)
	return connect.NewResponse(newDest), nil
}

func (s *TravelServer) UpdateDestination(ctx context.Context, req *connect.Request[v1.UpdateDestinationRequest]) (*connect.Response[v1.Destination], error) {
	updated := req.Msg.Destination
	for i, d := range s.destinations {
		if d.Ref == updated.Ref {
			s.destinations[i] = updated
			return connect.NewResponse(updated), nil
		}
	}
	return nil, connect.NewError(connect.CodeNotFound, fmt.Errorf("destination not found: %s", updated.Ref))
}

func (s *TravelServer) DeleteDestination(ctx context.Context, req *connect.Request[v1.DeleteDestinationRequest]) (*connect.Response[v1.EmptyResponse], error) {
	ref := req.Msg.Ref
	for i, d := range s.destinations {
		if d.Ref == ref {
			s.destinations = append(s.destinations[:i], s.destinations[i+1:]...)
			return connect.NewResponse(&v1.EmptyResponse{}), nil
		}
	}
	return nil, connect.NewError(connect.CodeNotFound, fmt.Errorf("destination not found: %s", ref))
}

func (s *TravelServer) GetActivity(ctx context.Context, req *connect.Request[v1.GetActivityRequest]) (*connect.Response[v1.Activity], error) {
	for _, a := range s.activities {
		if a.Ref == req.Msg.Ref {
			return connect.NewResponse(a), nil
		}
	}
	return nil, connect.NewError(connect.CodeNotFound, fmt.Errorf("activity not found: %s", req.Msg.Ref))
}

func (s *TravelServer) ListActivities(ctx context.Context, req *connect.Request[v1.ListActivitiesRequest]) (*connect.Response[v1.ListActivitiesResponse], error) {
	resp := connect.NewResponse(&v1.ListActivitiesResponse{
		Activities: s.activities,
	})
	return resp, nil
}

func (s *TravelServer) CreateActivity(ctx context.Context, req *connect.Request[v1.CreateActivityRequest]) (*connect.Response[v1.Activity], error) {
	newAct := req.Msg.Activity
	for _, a := range s.activities {
		if a.Ref == newAct.Ref {
			return nil, connect.NewError(connect.CodeAlreadyExists, fmt.Errorf("activity with ref %s already exists", a.Ref))
		}
	}
	s.activities = append(s.activities, newAct)
	return connect.NewResponse(newAct), nil
}

func (s *TravelServer) UpdateActivity(ctx context.Context, req *connect.Request[v1.UpdateActivityRequest]) (*connect.Response[v1.Activity], error) {
	updated := req.Msg.Activity
	for i, a := range s.activities {
		if a.Ref == updated.Ref {
			s.activities[i] = updated
			return connect.NewResponse(updated), nil
		}
	}
	return nil, connect.NewError(connect.CodeNotFound, fmt.Errorf("activity not found: %s", updated.Ref))
}

func (s *TravelServer) DeleteActivity(ctx context.Context, req *connect.Request[v1.DeleteActivityRequest]) (*connect.Response[v1.EmptyResponse], error) {
	ref := req.Msg.Ref
	for i, a := range s.activities {
		if a.Ref == ref {
			s.activities = append(s.activities[:i], s.activities[i+1:]...)
			return connect.NewResponse(&v1.EmptyResponse{}), nil
		}
	}
	return nil, connect.NewError(connect.CodeNotFound, fmt.Errorf("activity not found: %s", ref))
}

func (s *TravelServer) BookDestination(ctx context.Context, req *connect.Request[v1.BookingRequest]) (*connect.Response[v1.BookingResponse], error) {
	return connect.NewResponse(&v1.BookingResponse{
		Status:    v1.BookingStatus_BOOKING_STATUS_CONFIRMED,
		BookingId: fmt.Sprintf("booking-%s", req.Msg.UserId),
	}), nil
}

func withCORS(h http.Handler) http.Handler {
	middleware := cors.New(cors.Options{
		AllowedOrigins: []string{"example.com"},
		AllowedMethods: connectcors.AllowedMethods(),
		AllowedHeaders: connectcors.AllowedHeaders(),
		ExposedHeaders: connectcors.ExposedHeaders(),
	})
	return middleware.Handler(h)
}

func main() {
	activities, destinations := load()

	server := &TravelServer{
		activities:   activities,
		destinations: destinations,
	}

	mux := http.NewServeMux()
	path, handler := spacev1connect.NewTravelServiceHandler(server)
	mux.Handle(path, handler)

	addr := "localhost:8080"
	fmt.Println("Server running at", addr)
	http.ListenAndServe(
		addr,
		h2c.NewHandler(withCORS(mux), &http2.Server{}),
	)
}
