using System.Collections;
using UnityEngine;

[RequireComponent(typeof(PlayerInput), typeof(PlayerMovement), typeof(PlayerBoundaries))]
[RequireComponent(typeof(WeaponManager), typeof(WeaponController), typeof(Rigidbody))]
[RequireComponent(typeof(SphereCollider), typeof(ParticleSystem))]
public class PlayerController : MonoBehaviour {
    [SerializeField] public PlayerData playerData;
    public float killCounter;
    private IEnumerator _coroutine;
    private EnemySpawn _enemySpawn;
    private float _timeSinceLastKill;
    private float _playerHealth;

    private void Awake(){
        GetComponent<Rigidbody>();
        killCounter = 0f;
        _enemySpawn = GameObject.FindWithTag("Respawn").GetComponent<EnemySpawn>();
        _timeSinceLastKill = 1f;
        _playerHealth = playerData.health;
    }

    private void Update(){
        //charges shield and boost!
        playerData.RechargeTimer();
        _timeSinceLastKill -= Time.deltaTime;
        _enemySpawn.timeBetweenSpawn -= killCounter;
        if (_timeSinceLastKill <= 0) {
            _timeSinceLastKill = 1f;
            killCounter = 0f;
            _enemySpawn.timeBetweenSpawn = 5f;
        }
    }

    private void OnCollisionEnter(Collision other){
        if (!other.collider.CompareTag("Enemy")) return;
        _coroutine = CollisionManager(other);
        StartCoroutine(_coroutine);
    }

    private IEnumerator CollisionManager(Collision other){
        EnemyController enemyController = other.gameObject.GetComponent<EnemyController>();
        Rigidbody enemyBody = other.gameObject.GetComponent<Rigidbody>();
        TakeDamage(enemyController.crashDamage);
        Transform transform1 = transform;
        Vector3 position = transform1.position;
        Vector2 bounceOffForce = new Vector2(position.x, position.y);
        enemyBody.AddForce(bounceOffForce, ForceMode.Impulse);
        yield return new WaitForSeconds(0.5f);
        enemyController.TakeDamage(playerData.crashDamage);
    }


    private void TakeDamage(float damage){
        if (playerData.ShieldIsActive) return;
        _playerHealth = -damage;
        print("took " + damage + " healt is now " + _playerHealth);
        if (_playerHealth <= 0f) { }

        //GAME OVER!
    }
}