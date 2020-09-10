using UnityEngine;

public class EnemyController : MonoBehaviour {
    [SerializeField] public EnemyData enemyData;
    private Vector3 _moveDirection;
    private float _moveSpeed;
    private Transform _playerTransform;
    private Rigidbody _rigidBody;

    private void Awake(){
        _rigidBody = GetComponent<Rigidbody>();
        _playerTransform = GameObject.FindWithTag("Player").transform;
        _moveSpeed = -enemyData.moveSpeed;

        Vector2 velocity = new Vector2(_moveSpeed * Random.Range(0.5f, 3f),
            Mathf.Sin(Mathf.PI * Random.Range(0.5f, _moveSpeed)));

        _rigidBody.velocity = velocity;
    }


    private void FixedUpdate(){
        if (gameObject.activeSelf) Move();
    }

    private void OnBecameInvisible(){
        EnemySpawn.NumberOfEnemies += 1;
        GameObject o = gameObject;
        EnemySpawn.RespawnOnDeath(o);
    }

    public void TakeDamage(float damage){
        enemyData.health = -damage;
        if (enemyData.health <= 0f) {
            EnemySpawn.NumberOfEnemies += 1;
            GameObject o = gameObject;
            EnemySpawn.RespawnOnDeath(o);
        }
    }

    private void Move(){
        Vector2 velocity = new Vector2(_rigidBody.velocity.x,
            Mathf.Sin(Mathf.PI * Time.deltaTime));
        _rigidBody.velocity = velocity;
    }
}