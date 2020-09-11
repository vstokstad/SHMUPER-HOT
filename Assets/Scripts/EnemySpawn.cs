using System;
using System.Collections.Generic;
using UnityEngine;
using Random = UnityEngine.Random;

public class EnemySpawn : MonoBehaviour {
    private const string _enemyTag = "Enemy";
    public int numberOfEnemies = 10;

    [SerializeField] private GameObject enemyShip;
    private Vector3 _enemyDirection;
    private List<GameObject> _enemyShips;
    private Vector3 _initialPosition;

    private float _spawnTimer = 3f;
    [NonSerialized] public float timeBetweenSpawn = 3f;


    private float PositionY => Random.Range(GameManager.CameraBounds.y, -8);

    private float PositionX => GameManager.CameraBounds.x + 2f;


    private void Awake(){
        _enemyShips = new List<GameObject>();
        for (int i = 0; i < numberOfEnemies; i++) {
            _initialPosition = new Vector3(PositionX, PositionY, 0f);
            _enemyShips.Add(Instantiate(Resources.Load(_enemyTag, typeof(GameObject)), transform, true) as GameObject);
            _enemyShips[i].transform.position = _initialPosition;
        }
    }

    private void Update(){
        if (!SpawnTimer()) return;
        Spawn();
        _spawnTimer = timeBetweenSpawn;
    }

    private bool SpawnTimer(){
        _spawnTimer -= Time.deltaTime;
        return _spawnTimer <= 0f;
    }

    private void Spawn(){
        foreach (GameObject enemy in _enemyShips) {
            if (enemy.activeSelf) continue;
            _initialPosition.x = PositionX;
            _initialPosition.y = PositionY;
            enemy.transform.position = _initialPosition;
            enemy.SetActive(true);
            enemy.GetComponent<MeshRenderer>().enabled = true;
            break;
        }
    }
}