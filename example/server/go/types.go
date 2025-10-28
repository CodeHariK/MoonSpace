package main

import (
	"encoding/json"
	"log"
	"os"
	"path/filepath"

	v1 "github.com/codeharik/moonspace/proto/v1"
)

type Activity struct {
	Name           string  `json:"name"`
	Description    string  `json:"description"`
	LocationName   string  `json:"locationName"`
	Duration       float32 `json:"duration"`
	TimeOfDay      string  `json:"timeOfDay"`
	FamilyFriendly bool    `json:"familyFriendly"`
	Price          int     `json:"price"`
	DestinationRef string  `json:"destinationRef"`
	Ref            string  `json:"ref"`
	ImageURL       string  `json:"imageUrl"`
}

type Destination struct {
	Ref       string   `json:"ref"`
	Name      string   `json:"name"`
	Country   string   `json:"country"`
	Continent string   `json:"continent"`
	KnownFor  string   `json:"knownFor"`
	Tags      []string `json:"tags"`
	ImageURL  string   `json:"imageUrl"`
}

func (a Activity) ToProto() *v1.Activity {
	return &v1.Activity{
		Ref:            a.Ref,
		Name:           a.Name,
		Description:    a.Description,
		LocationName:   a.LocationName,
		Duration:       a.Duration,
		TimeOfDay:      a.TimeOfDay,
		FamilyFriendly: a.FamilyFriendly,
		Price:          int32(a.Price),
		DestinationRef: a.DestinationRef,
		ImageUrl:       a.ImageURL,
	}
}

func (d Destination) ToProto() *v1.Destination {
	return &v1.Destination{
		Ref:       d.Ref,
		Name:      d.Name,
		Country:   d.Country,
		Continent: d.Continent,
		KnownFor:  d.KnownFor,
		Tags:      d.Tags,
		ImageUrl:  d.ImageURL,
	}
}

func load() (activities []*v1.Activity, destinations []*v1.Destination) {
	// Load activities
	{
		path := filepath.Join("..", "..", "assets", "activities.json")
		data, err := os.ReadFile(path)
		if err != nil {
			log.Fatalf("Failed to read activities.json: %v", err)
		}
		var rawActivities []Activity
		if err := json.Unmarshal(data, &rawActivities); err != nil {
			log.Fatalf("Failed to parse activities.json: %v", err)
		}
		for _, a := range rawActivities {
			activity := a.ToProto()
			activities = append(activities, activity)
		}
	}

	// Load destinations
	{
		path := filepath.Join("..", "..", "assets", "destinations.json")
		data, err := os.ReadFile(path)
		if err != nil {
			log.Fatalf("Failed to read destinations.json: %v", err)
		}
		var rawDestinations []Destination
		if err := json.Unmarshal(data, &rawDestinations); err != nil {
			log.Fatalf("Failed to parse destinations.json: %v", err)
		}
		for _, d := range rawDestinations {
			dest := d.ToProto()
			destinations = append(destinations, dest)
		}
	}

	return
}
